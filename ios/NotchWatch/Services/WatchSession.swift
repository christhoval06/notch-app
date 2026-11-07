import Foundation
import WatchConnectivity

final class WatchSession: NSObject, WCSessionDelegate {
    var onChange: (() -> Void)?
    var onError: (() -> Void)?
    private let queue: WatchQueueStore
    private let session = WCSession.default
    init(queue: WatchQueueStore) { self.queue = queue; super.init() }
    func activate() {
        guard WCSession.isSupported() else { return }
        session.delegate = self
        session.activate()
    }
    func refresh(requestUpdate: Bool = false) {
        guard session.activationState == .activated else { activate(); return }
        receiveContext(session.receivedApplicationContext)
        guard queue.snapshot?.state == "active" else { return }
        let inFlight = Set(session.outstandingUserInfoTransfers.compactMap { $0.userInfo["id"] as? String })
        for command in queue.pendingCommands() where !inFlight.contains(command.id) {
            session.transferUserInfo(command.dictionary)
        }
        if requestUpdate && session.isReachable { session.sendMessage(["kind": "refresh"], replyHandler: nil, errorHandler: nil) }
    }
    private func receiveContext(_ context: [String: Any]) {
        guard !context.isEmpty else { return }
        do {
            let snapshot = try JSONDecoder().decode(WatchSnapshot.self, from: WatchProtocol.data(context))
            let previous = queue.snapshot?.generation
            try queue.apply(snapshot)
            if previous != queue.snapshot?.generation {
                for transfer in session.outstandingUserInfoTransfers { transfer.cancel() }
            }
            onChange?()
        } catch { onError?() }
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if error != nil { self?.onError?(); return }
            self?.refresh(requestUpdate: true)
        }
    }
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async { [weak self] in self?.refresh() }
    }
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        DispatchQueue.main.async { [weak self] in
            self?.receiveContext(applicationContext)
            self?.refresh()
        }
    }
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String: Any] = [:]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            do {
                let receipt = try JSONDecoder().decode(WatchReceipt.self, from: WatchProtocol.data(userInfo))
                try self.queue.apply(receipt)
                self.onChange?()
            } catch { self.onError?() }
        }
    }
}
