import Foundation
import Combine

final class WatchCompanionStore: ObservableObject {
    @Published private(set) var snapshot: WatchSnapshot?
    @Published private(set) var entries: [WatchCommand] = []
    @Published private(set) var rejections: [String: String] = [:]
    @Published var errorKey: String?
    @Published private(set) var isSaving = false
    private var queue: WatchQueueStore?
    private var session: WatchSession?
    init() {
        do {
            let folder = try FileManager.default.url(for: .applicationSupportDirectory,
                in: .userDomainMask, appropriateFor: nil, create: true)
            let queue = try WatchQueueStore(file: folder.appendingPathComponent("NotchWatch/watch.json"))
            self.queue = queue
            let session = WatchSession(queue: queue)
            self.session = session
            session.onChange = { [weak self] in self?.reload() }
            session.onError = { [weak self] in self?.errorKey = "watchSyncUnavailable" }
            reload()
            session.activate()
        } catch { errorKey = "watchStorageUnavailable" }
    }
    var canCreate: Bool { snapshot?.allowsPrivateContent == true && queue != nil }
    var pendingCount: Int { queue?.pendingCommands().count ?? 0 }
    func refresh() { session?.refresh(requestUpdate: true) }
    private func reload() {
        snapshot = queue?.snapshot
        entries = queue?.entries ?? []
        rejections = queue?.rejected ?? [:]
    }
    func submit(_ draft: WatchEntryDraft) -> Bool {
        guard !isSaving, canCreate, let queue else { errorKey = "watchOpenPhone"; return false }
        isSaving = true
        defer { isSaving = false }
        do {
            let command = try draft.command(generation: snapshot?.generation, now: Date())
            try queue.enqueue(command)
            reload()
            session?.refresh(requestUpdate: true)
            return true
        } catch WatchError.queueFull { errorKey = "watchQueueFull" }
        catch WatchError.invalid { errorKey = "watchInvalidEntry" }
        catch { errorKey = "watchStorageUnavailable" }
        return false
    }
    func discard(_ id: String) {
        do { try queue?.discard(id); reload() }
        catch { errorKey = "watchStorageUnavailable" }
    }
}
