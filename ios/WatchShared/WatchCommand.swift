import Foundation

struct WatchCommand: Codable, Identifiable, Equatable {
    let schemaVersion: Int
    let kind: String
    let generation: String
    let id: String
    let capturedAtMs: Int64
    let partnerLabel: String
    let rating: Int
    let orgasmCount: Int
    let protected: Bool

    func validated() throws -> WatchCommand {
        var label = partnerLabel.trimmingCharacters(in: .whitespacesAndNewlines)
        if label.hasPrefix("@") || label.hasPrefix("＠") { label.removeFirst() }
        label = label.trimmingCharacters(in: .whitespacesAndNewlines)
        guard schemaVersion == WatchProtocol.version, kind == "entry",
              !generation.isEmpty, generation.count <= 64, UUID(uuidString: id) != nil,
              capturedAtMs >= 0, capturedAtMs <= 8_640_000_000_000_000,
              !label.isEmpty, label.utf16.count <= 80,
              (1...10).contains(rating), (0...99).contains(orgasmCount) else { throw WatchError.invalid }
        return WatchCommand(schemaVersion: schemaVersion, kind: kind, generation: generation,
            id: id.lowercased(), capturedAtMs: capturedAtMs, partnerLabel: label,
            rating: rating, orgasmCount: orgasmCount, protected: protected)
    }
    var dictionary: [String: Any] {
        ["schemaVersion": schemaVersion, "kind": kind, "generation": generation,
         "id": id, "capturedAtMs": capturedAtMs, "partnerLabel": partnerLabel,
         "rating": rating, "orgasmCount": orgasmCount, "protected": protected]
    }
}
