import Foundation

final class WatchQueueStore {
    private struct State: Codable {
        var snapshot: WatchSnapshot?
        var commands: [WatchCommand] = []
        var rejections: [String: String] = [:]
        var accepted: [String] = []
        var retiredGenerations: Set<String> = []
    }
    private let file: URL
    private var state: State
    var snapshot: WatchSnapshot? { state.snapshot }
    var rejected: [String: String] { state.rejections }
    var entries: [WatchCommand] { state.commands }
    init(file: URL) throws {
        self.file = file
        state = FileManager.default.fileExists(atPath: file.path)
            ? try JSONDecoder().decode(State.self, from: Data(contentsOf: file)) : State()
    }
    private func update(_ operation: () throws -> Void) throws {
        let previous = state
        do {
            try operation()
            try FileManager.default.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
            let data = try JSONEncoder().encode(state)
            #if os(watchOS)
            try data.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
            #else
            try data.write(to: file, options: .atomic)
            #endif
            var url = file
            var values = URLResourceValues()
            values.isExcludedFromBackup = true
            try url.setResourceValues(values)
        } catch { state = previous; throw error }
    }
    func enqueue(_ value: WatchCommand) throws {
        let command = try value.validated()
        guard let snapshot, snapshot.state == "active", snapshot.generation == command.generation else { throw WatchError.notPaired }
        if state.accepted.contains(command.id) { return }
        if let previous = state.commands.first(where: { $0.id == command.id }) {
            guard previous == command else { throw WatchError.invalid }
            return
        }
        guard state.commands.count < WatchProtocol.queueLimit else { throw WatchError.queueFull }
        try update { state.commands.append(command) }
    }
    func pendingCommands() -> [WatchCommand] {
        state.commands.filter { state.rejections[$0.id] == nil }
    }
    func discard(_ id: String) throws {
        guard state.rejections[id] != nil else { return }
        try update {
            state.commands.removeAll { $0.id == id }
            state.rejections.removeValue(forKey: id)
        }
    }
    func apply(_ receipt: WatchReceipt) throws {
        guard receipt.schemaVersion == 1, receipt.kind == "receipt",
              receipt.generation == snapshot?.generation,
              state.commands.contains(where: { $0.id == receipt.id }),
              ["accepted", "rejected"].contains(receipt.status) else { return }
        try update {
            if receipt.status == "accepted" {
                state.commands.removeAll { $0.id == receipt.id }
                state.rejections.removeValue(forKey: receipt.id)
                state.accepted.append(receipt.id)
                state.accepted = Array(state.accepted.suffix(500))
            } else { state.rejections[receipt.id] = receipt.reason ?? "invalid_entry" }
        }
    }
    func apply(_ value: WatchSnapshot) throws {
        guard value.schemaVersion == 1, value.kind == "snapshot",
              ["active", "disabled", "reset"].contains(value.state),
              !value.generation.isEmpty, !state.retiredGenerations.contains(value.generation) else { return }
        if let old = snapshot, old.generation == value.generation, old.revision >= value.revision { return }
        try update {
            if let old = snapshot, old.generation != value.generation {
                state.retiredGenerations.insert(old.generation)
                state.commands.removeAll()
                state.rejections.removeAll()
                state.accepted.removeAll()
            }
            state.snapshot = value
            if value.state == "reset" {
                state.commands.removeAll()
                state.rejections.removeAll()
                state.accepted.removeAll()
            }
        }
    }
}
