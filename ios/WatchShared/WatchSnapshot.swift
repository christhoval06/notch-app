import Foundation

struct WatchSnapshot: Codable {
    let schemaVersion: Int
    let kind: String
    let generation: String
    let revision: Int
    let state: String
    var allowsPrivateContent: Bool { state == "active" }
    var partnerNames: [String]?
    var moodOptions: [String]?
    var tagOptions: [WatchTagOption]?
    var generatedAtMs: Int64?
    var locale: String?
    var monthId: String?
    var abstinenceReferenceMs: Int64?
    var zeroState: Bool?
    var levelName: String?
    var xp: Int?
    var progress: Double?
    var nextXp: Int?
    var entryCount: Int?
    var averageRating: Double?
    var protectionRate: Double?
}

struct WatchTagOption: Codable, Identifiable {
    let key: String
    let label: String
    var id: String { key }
}
