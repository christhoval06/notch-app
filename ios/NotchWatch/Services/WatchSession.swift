import Foundation
import WatchConnectivity

final class WatchSession: NSObject, WCSessionDelegate {
    var onChange: (() -> Void)?
    var onError: (() -> Void)?
    private let queue: WatchQueueStore
    private let session = WCSession.default
    private var liveTransfers = Set<String>()
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
        #if !targetEnvironment(simulator)
        let inFlight = Set(session.outstandingUserInfoTransfers.compactMap { $0.userInfo["id"] as? String })
        #endif
        for command in queue.pendingCommands() {
            #if !targetEnvironment(simulator)
            if !inFlight.contains(command.id) { session.transferUserInfo(command.dictionary) }
            #endif
            if session.isReachable { sendLive(command) }
        }
        if requestUpdate && session.isReachable { session.sendMessage(["kind": "refresh"], replyHandler: nil, errorHandler: nil) }
    }
    private func sendLive(_ command: WatchCommand) {
        guard liveTransfers.insert(command.id).inserted else { return }
        session.sendMessage(command.dictionary, replyHandler: { [weak self] reply in
            DispatchQueue.main.async {
                guard let self else { return }
                self.liveTransfers.remove(command.id)
                // An inbox acknowledgement is not a saved-entry receipt.
                if reply["kind"] as? String == "receipt" { self.receiveReceipt(reply) }
            }
        }, errorHandler: { [weak self] _ in
            DispatchQueue.main.async { self?.liveTransfers.remove(command.id) }
        })
    }
    private func receiveReceipt(_ value: [String: Any]) {
        do {
            let receipt = try JSONDecoder().decode(WatchReceipt.self, from: WatchProtocol.data(value))
            try queue.apply(receipt)
            onChange?()
        } catch { onError?() }
    }
    private func receiveContext(_ context: [String: Any]) {
        guard !context.isEmpty else { return }
        do {
            let snapshot = try JSONDecoder().decode(WatchSnapshot.self, from: WatchProtocol.data(context))
            let previous = queue.snapshot?.generation
            try queue.apply(snapshot)
            if previous != queue.snapshot?.generation {
                liveTransfers.removeAll()
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
        DispatchQueue.main.async { [weak self] in self?.receiveReceipt(userInfo) }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async { [weak self] in self?.receiveReceipt(message) }
    }
}
