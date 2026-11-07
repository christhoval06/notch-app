import Foundation
func check(_ value: Bool) { assert(value) }
let folder = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
defer { try? FileManager.default.removeItem(at: folder) }
let store = try WatchPhoneInbox(file: folder.appendingPathComponent("inbox.json"))
var map = try JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: "test/fixtures/watch_companion/entry.json"))) as! [String: Any]
map["generation"] = store.generation
let command = try JSONDecoder().decode(WatchCommand.self, from: WatchProtocol.data(map)).validated()
check(try store.receive(command) == nil)
let restored = try WatchPhoneInbox(file: folder.appendingPathComponent("inbox.json"))
assert(restored.commands.count == 1)
check(try restored.receive(command) == nil)
let receipt = WatchReceipt(schemaVersion: 1, kind: "receipt", generation: command.generation, id: command.id, status: "accepted")
try restored.complete(receipt)
assert(restored.commands.isEmpty)
check(try restored.receive(command)?.status == "accepted")
var changed = command.dictionary
changed["rating"] = 9
let conflict = try JSONDecoder().decode(WatchCommand.self, from: WatchProtocol.data(changed)).validated()
let conflictReceipt = try restored.receive(conflict)
assert(conflictReceipt?.reason == "conflicting_id", "Completed IDs must validate payloads")

var changedDetails = command.dictionary
changedDetails["moodEmoji"] = "🔥"
let newDetails = try JSONDecoder().decode(WatchCommand.self, from: WatchProtocol.data(changedDetails)).validated()
check(try restored.receive(newDetails)?.reason == "conflicting_id")

let previous = restored.generation
try restored.rotate()
assert(restored.generation != previous)
check(try restored.receive(command)?.reason == "reset")
print("Passed native inbox durability, duplicate receipt and reset-generation checks")
