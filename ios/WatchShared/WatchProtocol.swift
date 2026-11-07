import Foundation

enum WatchProtocol {
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
