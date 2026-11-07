import Foundation
import WatchConnectivity

final class WatchPhoneSession: NSObject, WCSessionDelegate {
    let inbox: WatchPhoneInbox
    var onInbox: (() -> Void)?
    private let session = WCSession.default
    private var pendingContext: [String: Any]?
    init(inbox: WatchPhoneInbox) { self.inbox = inbox; super.init() }
    func activate() {
        guard WCSession.isSupported() else { return }
        session.delegate = self
        session.activate()
    }
    func publish(_ payload: [String: Any]) throws {
        let context = try inbox.context(payload)
        pendingContext = context
        if session.activationState == .activated, session.isPaired {
            try session.updateApplicationContext(context)
        }
    }
    func send(_ receipt: WatchReceipt) throws {
        let data = try JSONEncoder().encode(receipt)
        let value = try JSONSerialization.jsonObject(with: data) as! [String: Any]
        guard session.activationState == .activated else { return }
        #if !targetEnvironment(simulator)
        session.transferUserInfo(value)
        #endif
        if session.isReachable { session.sendMessage(value, replyHandler: nil, errorHandler: nil) }
    }
    func rotate() throws {
        for transfer in session.outstandingUserInfoTransfers { transfer.cancel() }
        try inbox.rotate()
        try? publish(["state": "reset"])
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if let context = self?.pendingContext, session.isPaired {
                try? session.updateApplicationContext(context)
            }
            if error == nil { self?.onInbox?() }
        }
    }
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) { session.activate() }
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async { [weak self] in self?.onInbox?() }
    }
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            do {
                if let receipt = try self.receiveEntry(userInfo) { try self.send(receipt) }
            } catch { NSLog("Watch inbox deferred an invalid or unavailable transfer") }
        }
    }
    private func receiveEntry(_ value: [String: Any]) throws -> WatchReceipt? {
        let data = try WatchProtocol.data(value)
        let command = try JSONDecoder().decode(WatchCommand.self, from: data).validated()
        let receipt = try inbox.receive(command)
        if receipt == nil { onInbox?() }
        return receipt
    }
    func session(_ session: WCSession, didReceiveMessage message: [String: Any], replyHandler: @escaping ([String: Any]) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { replyHandler(["kind": "retry"]); return }
            do {
                if let receipt = try self.receiveEntry(message) {
                    let data = try JSONEncoder().encode(receipt)
                    replyHandler(try JSONSerialization.jsonObject(with: data) as! [String: Any])
                } else { replyHandler(["kind": "inbox_ack"]) }
            } catch { replyHandler(["kind": "retry"]) }
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async { [weak self] in self?.onInbox?() }
    }
}
