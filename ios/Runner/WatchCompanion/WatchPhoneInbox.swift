import Foundation
import CryptoKit

final class WatchPhoneInbox {
    private struct State: Codable {
        var generation = UUID().uuidString.lowercased()
        var revision = 0
        var entries: [String: WatchCommand] = [:]
        var receipts: [String: WatchReceipt] = [:]
        var fingerprints: [String: String]?
    }
    private let file: URL
    private var state: State
    var generation: String { state.generation }
    var commands: [WatchCommand] { state.entries.values.sorted { $0.capturedAtMs < $1.capturedAtMs } }
    init(file: URL) throws {
        self.file = file
        if FileManager.default.fileExists(atPath: file.path) {
            state = try JSONDecoder().decode(State.self, from: Data(contentsOf: file))
        } else { state = State() }
        try persist()
    }
    private func persist() throws {
        try FileManager.default.createDirectory(at: file.deletingLastPathComponent(), withIntermediateDirectories: true)
        let data = try JSONEncoder().encode(state)
        #if os(iOS)
        try data.write(to: file, options: [.atomic, .completeFileProtectionUntilFirstUserAuthentication])
        #else
        try data.write(to: file, options: .atomic)
        #endif
        var url = file
        var values = URLResourceValues()
        values.isExcludedFromBackup = true
        try url.setResourceValues(values)
    }
    func receive(_ command: WatchCommand) throws -> WatchReceipt? {
        func rejected(_ reason: String) -> WatchReceipt {
            WatchReceipt(schemaVersion: 1, kind: "receipt", generation: command.generation,
                id: command.id, status: "rejected", reason: reason)
        }
        guard command.generation == generation else { return rejected("reset") }
        if let old = state.entries[command.id], old != command { return rejected("conflicting_id") }
        let fingerprint = SHA256.hash(data: try WatchProtocol.data(command.dictionary))
            .map { String(format: "%02x", $0) }.joined()
        if let receipt = state.receipts[command.id], let previous = state.fingerprints?[command.id] {
            return previous == fingerprint ? receipt : rejected("conflicting_id")
        }
        guard state.entries[command.id] != nil || state.entries.count < WatchProtocol.queueLimit else { throw WatchError.queueFull }
        let previous = state
        state.entries[command.id] = command
        if state.fingerprints == nil { state.fingerprints = [:] }
        state.fingerprints?[command.id] = fingerprint
        do { try persist() } catch { state = previous; throw error }
        return nil
    }
    func complete(_ receipt: WatchReceipt) throws {
        guard receipt.generation == generation, receipt.schemaVersion == 1,
              ["accepted", "rejected"].contains(receipt.status) else { throw WatchError.invalid }
        let previous = state
        state.receipts[receipt.id] = receipt
        state.entries.removeValue(forKey: receipt.id)
        if state.receipts.count > 500 {
            for key in state.receipts.keys.sorted().prefix(state.receipts.count - 500) {
                state.receipts.removeValue(forKey: key)
                state.fingerprints?.removeValue(forKey: key)
            }
        }
        do { try persist() } catch { state = previous; throw error }
    }
    func context(_ payload: [String: Any]) throws -> [String: Any] {
        if payload["state"] as? String == "active", payload["generation"] as? String != generation { throw WatchError.invalid }
        let previous = state
        state.revision += 1
        do { try persist() } catch { state = previous; throw error }
        var value = payload
        value["kind"] = "snapshot"
        value["schemaVersion"] = 1
        value["generation"] = generation
        value["revision"] = state.revision
        return value
    }
    func rotate() throws {
        let previous = state
        state = State()
        do { try persist() } catch { state = previous; throw error }
    }
}
