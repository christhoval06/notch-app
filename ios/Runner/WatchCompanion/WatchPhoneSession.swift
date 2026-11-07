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
        if session.activationState == .activated { session.transferUserInfo(value) }
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
                let data = try WatchProtocol.data(userInfo)
                let command = try JSONDecoder().decode(WatchCommand.self, from: data).validated()
                if let receipt = try self.inbox.receive(command) { try self.send(receipt) }
                else { self.onInbox?() }
            } catch { NSLog("Watch inbox deferred an invalid or unavailable transfer") }
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async { [weak self] in self?.onInbox?() }
    }
}
