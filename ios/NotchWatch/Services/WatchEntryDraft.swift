import Foundation

struct WatchEntryDraft {
    var partner = ""
    var rating = 8
    var orgasmCount = 0
    var protection: Bool?
    var moodEmoji: String?
    var tags: [String] = []
    func command(generation: String?, now: Date, id: UUID = UUID()) throws -> WatchCommand {
        guard let generation, !generation.isEmpty else { throw WatchError.notPaired }
        guard let protection else { throw WatchError.invalid }
        return try WatchCommand(schemaVersion: 1, kind: "entry", generation: generation,
            id: id.uuidString.lowercased(), capturedAtMs: Int64(now.timeIntervalSince1970 * 1000),
            partnerLabel: partner, rating: rating, orgasmCount: orgasmCount, protected: protection,
            moodEmoji: moodEmoji, tags: tags.isEmpty ? nil : tags).validated()
    }
}
