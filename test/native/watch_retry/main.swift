import Foundation
final class Resource { let data: Data; init(_ data: Data) { self.data = data } }
let file = FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString)
defer { try? FileManager.default.removeItem(at: file) }
let retry = WatchBridgeRetry<Resource>()
assert(retry.resolve { Resource(try Data(contentsOf: file)) } == nil)
try Data("available".utf8).write(to: file)
let recovered = retry.resolve { Resource(try Data(contentsOf: file)) }
assert(recovered?.data == Data("available".utf8))
try FileManager.default.removeItem(at: file)
let retained = retry.resolve { Resource(try Data(contentsOf: file)) }
assert(retained === recovered)
print("Passed native bridge recovery after transient storage failure")
