import Foundation

struct WatchSnapshot: Codable {
    let schemaVersion: Int
    let kind: String
    let generation: String
    let revision: Int
    let state: String
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
