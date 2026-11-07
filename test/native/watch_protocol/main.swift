import Foundation
let data = try Data(contentsOf: URL(fileURLWithPath: "test/fixtures/watch_companion/entry.json"))
let command = try JSONDecoder().decode(WatchCommand.self, from: data).validated()
assert(command.partnerLabel == "Sample")
assert(command.capturedAtMs == 1796079600000)
let roundTrip = try JSONDecoder().decode(WatchCommand.self, from: JSONEncoder().encode(command))
assert(roundTrip == command)
var invalid = command.dictionary
invalid["rating"] = 11
assert((try? JSONDecoder().decode(WatchCommand.self, from: WatchProtocol.data(invalid)).validated()) == nil)
print("Passed native command round-trip, timestamp, normalization and validation checks")
