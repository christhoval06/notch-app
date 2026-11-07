import Foundation

public enum WCSessionActivationState { case notActivated, activated }
public protocol WCSessionDelegate: AnyObject {
    func session(_ session: WCSession, didReceiveMessage message: [String: Any])
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void)
    func session(_ session: WCSession, didReceiveApplicationContext context: [String: Any])
}
public extension WCSessionDelegate {
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {}
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {}
    func session(_ session: WCSession, didReceiveApplicationContext context: [String: Any]) {}
}
public final class WCSessionUserInfoTransfer {
    public let userInfo: [String: Any]
    public init(_ userInfo: [String: Any]) { self.userInfo = userInfo }
    public func cancel() {}
}
public final class WCSession {
    public static var `default` = WCSession()
    public static func isSupported() -> Bool { true }
    public weak var delegate: (any WCSessionDelegate)?
    public weak var peer: WCSession?
    public var activationState = WCSessionActivationState.activated
    public var isPaired = true
    public var isReachable = true
    public var failNextMessage = false
    public var receivedApplicationContext: [String: Any] = [:]
    public var outstandingUserInfoTransfers: [WCSessionUserInfoTransfer] = []
    public init() {}
    public func activate() { activationState = .activated }
    public func updateApplicationContext(_ context: [String: Any]) throws {
        peer?.receivedApplicationContext = context
        if let peer { peer.delegate?.session(peer, didReceiveApplicationContext: context) }
    }
    // Model Simulator: background user-info transfers never reach the peer.
    @discardableResult public func transferUserInfo(_ value: [String: Any]) -> WCSessionUserInfoTransfer {
        let transfer = WCSessionUserInfoTransfer(value)
        outstandingUserInfoTransfers.append(transfer)
        return transfer
    }
    public func sendMessage(_ value: [String: Any], replyHandler: (([String: Any]) -> Void)?, errorHandler: ((Error) -> Void)?) {
        guard !failNextMessage, isReachable, let peer, peer.isReachable else {
            failNextMessage = false
            errorHandler?(NSError(domain: "test.unreachable", code: 1))
            return
        }
        if let replyHandler { peer.delegate?.session(peer, didReceiveMessage: value, replyHandler: replyHandler) }
        else { peer.delegate?.session(peer, didReceiveMessage: value) }
    }
}
