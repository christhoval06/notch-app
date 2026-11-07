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

var detailed = command.dictionary
detailed["moodEmoji"] = "🥰"
detailed["tags"] = ["tag_hotel", "tag_date"]
let enriched = try JSONDecoder().decode(WatchCommand.self, from: WatchProtocol.data(detailed)).validated()
assert(enriched.dictionary["moodEmoji"] as? String == "🥰")
assert(enriched.dictionary["tags"] as? [String] == ["tag_date", "tag_hotel"])

for invalid: [String: Any] in [["moodEmoji": "unknown"], ["tags": ["unknown"]], ["tags": ["tag_date", "tag_date"]]] {
    var value = command.dictionary
    value.merge(invalid) { _, new in new }
    let decoded = try JSONDecoder().decode(WatchCommand.self, from: WatchProtocol.data(value))
    assert((try? decoded.validated()) == nil)
}
assert(command.dictionary["tags"] == nil && command.dictionary["moodEmoji"] == nil)
