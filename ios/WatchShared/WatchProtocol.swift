import Foundation

enum WatchProtocol {
    static let moods = ["🔥", "😈", "🥰", "😎", "😴", "🦄", "🤯", "💦", "🧘‍♂️", "🏆"]
    static let tags = ["tag_morning", "tag_quickie", "tag_date", "tag_travel",
        "tag_anniversary", "tag_celebration", "tag_oral", "tag_anal", "tag_toys", "tag_kinky",
        "tag_vanilla", "tag_domsub", "tag_massage", "tag_outdoor", "tag_car", "tag_hotel",
        "tag_shower", "tag_ons", "tag_fwb", "tag_reconciliation"]
    static let version = 1
    static let queueLimit = 100
    static let maxEnvelopeBytes = 16_384
    static let channel = "dev.christhoval.apps.notch/watch_companion"
    static func data(_ value: [String: Any]) throws -> Data {
        let data = try JSONSerialization.data(withJSONObject: value, options: [.sortedKeys])
        guard data.count <= maxEnvelopeBytes else { throw WatchError.invalid }
        return data
    }
}
enum WatchError: Error { case invalid, queueFull, notPaired }
