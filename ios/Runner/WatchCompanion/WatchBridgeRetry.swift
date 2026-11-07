import Foundation

final class WatchBridgeRetry<Resource: AnyObject> {
    private var value: Resource?
    func resolve(_ create: () throws -> Resource) -> Resource? {
        if let value { return value }
        do { let resource = try create(); value = resource; return resource }
        catch { return nil }
    }
}
