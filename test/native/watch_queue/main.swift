import Foundation
func check(_ value: Bool) { assert(value) }
let folder = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
defer { try? FileManager.default.removeItem(at: folder) }
let file = folder.appendingPathComponent("watch.json")
let queue = try WatchQueueStore(file: file)
var snapshot = WatchSnapshot(schemaVersion: 1, kind: "snapshot", generation: "g", revision: 1, state: "active")
snapshot.partnerNames = ["Sample"]
snapshot.moodOptions = ["🥰"]
snapshot.tagOptions = [WatchTagOption(key: "tag_date", label: "Date Night")]
try queue.apply(snapshot)
let command = WatchCommand(schemaVersion: 1, kind: "entry", generation: "g", id: UUID().uuidString.lowercased(), capturedAtMs: 1, partnerLabel: "Sample", rating: 8, orgasmCount: 1, protected: true, moodEmoji: "🥰", tags: ["tag_date"])
try queue.enqueue(command)
let restored = try WatchQueueStore(file: file)
assert(restored.pendingCommands().count == 1)
assert(restored.pendingCommands().first?.moodEmoji == "🥰")
assert(restored.pendingCommands().first?.tags == ["tag_date"])
assert(restored.snapshot?.partnerNames == ["Sample"])
assert(restored.snapshot?.tagOptions?.first?.label == "Date Night")
try restored.apply(WatchReceipt(schemaVersion: 1, kind: "receipt", generation: "g", id: command.id, status: "accepted"))
assert(restored.pendingCommands().isEmpty)
try restored.apply(WatchReceipt(schemaVersion: 1, kind: "receipt", generation: "g", id: command.id, status: "accepted"))
try restored.enqueue(command)
assert(restored.pendingCommands().isEmpty)
for _ in 0..<99 {
  try queue.enqueue(WatchCommand(schemaVersion: 1, kind: "entry", generation: "g", id: UUID().uuidString.lowercased(), capturedAtMs: 1, partnerLabel: "Sample", rating: 8, orgasmCount: 1, protected: true))
}

try queue.apply(WatchSnapshot(schemaVersion: 1, kind: "snapshot", generation: "g", revision: 2, state: "disabled"))
assert(queue.snapshot?.allowsPrivateContent == false)
assert(queue.pendingCommands().count == 100)
try queue.apply(WatchSnapshot(schemaVersion: 1, kind: "snapshot", generation: "g", revision: 3, state: "active"))
var fullRejected = false
do { try queue.enqueue(WatchCommand(schemaVersion: 1, kind: "entry", generation: "g", id: UUID().uuidString.lowercased(), capturedAtMs: 1, partnerLabel: "Sample", rating: 8, orgasmCount: 1, protected: true)) } catch { fullRejected = true }
assert(fullRejected)
try queue.apply(WatchSnapshot(schemaVersion: 1, kind: "snapshot", generation: "new", revision: 1, state: "reset"))
assert(queue.pendingCommands().isEmpty)
try queue.apply(snapshot)
assert(queue.snapshot?.generation == "new")
print("Passed queue persistence, acknowledgement, capacity and out-of-order reset checks")
