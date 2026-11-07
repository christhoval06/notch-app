import Foundation
import WatchConnectivity

func require(_ value: @autoclosure () -> Bool, _ message: String) {
    if !value() { print("FAIL: \(message)"); exit(1) }
}
func pump() { RunLoop.current.run(until: Date().addingTimeInterval(0.1)) }
let folder = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
defer { try? FileManager.default.removeItem(at: folder) }
let inbox = try WatchPhoneInbox(file: folder.appendingPathComponent("inbox.json"))
let queue = try WatchQueueStore(file: folder.appendingPathComponent("queue.json"))
try queue.apply(WatchSnapshot(schemaVersion: 1, kind: "snapshot", generation: inbox.generation, revision: 1, state: "active"))
let phoneWire = WCSession(), watchWire = WCSession()
phoneWire.peer = watchWire; watchWire.peer = phoneWire
WCSession.default = phoneWire
let phone = WatchPhoneSession(inbox: inbox)
WCSession.default = watchWire
let watch = WatchSession(queue: queue)
phone.activate(); watch.activate()
func command() -> WatchCommand {
    WatchCommand(schemaVersion: 1, kind: "entry", generation: inbox.generation,
        id: UUID().uuidString.lowercased(), capturedAtMs: 1, partnerLabel: "Sample",
        rating: 9, orgasmCount: 1, protected: true, moodEmoji: "🥰", tags: ["tag_date"])
}
func accept(_ entry: WatchCommand) throws {
    let receipt = WatchReceipt(schemaVersion: 1, kind: "receipt", generation: entry.generation, id: entry.id, status: "accepted")
    try inbox.complete(receipt)
    try phone.send(receipt)
}
let first = command()
try queue.enqueue(first)
watch.refresh(requestUpdate: true)
pump()
require(inbox.commands.count == 1, "reachable Watch entry must reach durable phone inbox without transferUserInfo delivery")
require(inbox.commands.first?.moodEmoji == "🥰", "entry details must survive live delivery")
require(queue.pendingCommands().count == 1, "inbox acknowledgement must not mark an entry saved")
try accept(first)
pump()
require(queue.pendingCommands().isEmpty, "durable acceptance must clear the Watch queue through the live receipt path")

let second = command()
try queue.enqueue(second)
watchWire.isReachable = false; phoneWire.isReachable = false
watch.refresh()
pump()
require(queue.pendingCommands().count == 1 && inbox.commands.isEmpty, "offline entry must stay pending")
watchWire.isReachable = true; phoneWire.isReachable = true
watch.sessionReachabilityDidChange(watchWire)
pump()
require(inbox.commands.count == 1, "reconnect must retry despite an outstanding background transfer")
watchWire.isReachable = false
try accept(second)
pump()
require(queue.pendingCommands().count == 1, "a lost receipt must leave the entry pending")
watchWire.isReachable = true
watchWire.failNextMessage = true
watch.refresh()
pump()
watch.refresh()
pump()
require(queue.pendingCommands().isEmpty, "retry after a failed live send must recover the persisted receipt")
require(inbox.commands.isEmpty, "duplicate delivery must not create a second inbox entry")
print("Passed real-session live entry delivery, durable acknowledgement, receipt, offline and reconnect checks")
