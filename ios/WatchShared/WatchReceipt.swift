import Foundation

struct WatchReceipt: Codable {
    let schemaVersion: Int
    let kind: String
    let generation: String
    let id: String
    let status: String
    var reason: String?
}
