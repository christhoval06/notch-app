import Foundation
var draft = WatchEntryDraft()
draft.partner = " @Sample "
assert((try? draft.command(generation: "g", now: Date())) == nil)
draft.protection = true
let eventTime = Date(timeIntervalSince1970: 1_795_993_200)
let command = try draft.command(generation: "g", now: eventTime)
assert(command.partnerLabel == "Sample")
assert(command.capturedAtMs == 1_795_993_200_000)
assert((try? draft.command(generation: nil, now: eventTime)) == nil)
draft.orgasmCount = 100
assert((try? draft.command(generation: "g", now: eventTime)) == nil)
draft.orgasmCount = 99
draft.rating = 10
let boundary = try draft.command(generation: "g", now: eventTime)
assert(boundary.rating == 10 && boundary.orgasmCount == 99)
print("Passed watch form validation, required protection, pairing and event-time checks")

draft.moodEmoji = "🥰"
draft.tags = ["tag_hotel", "tag_date"]
let details = try draft.command(generation: "g", now: eventTime)
assert(details.moodEmoji == "🥰" && details.tags == ["tag_date", "tag_hotel"])
