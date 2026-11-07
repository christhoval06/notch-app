import Flutter
import Foundation

final class WatchPlatformBridge {
    private let channel: FlutterMethodChannel
    private let phone: WatchPhoneSession
    init(messenger: FlutterBinaryMessenger) throws {
        let folder = try FileManager.default.url(for: .applicationSupportDirectory,
            in: .userDomainMask, appropriateFor: nil, create: true)
        let inbox = try WatchPhoneInbox(file: folder.appendingPathComponent("NotchWatch/inbox.json"))
        phone = WatchPhoneSession(inbox: inbox)
        channel = FlutterMethodChannel(name: WatchProtocol.channel, binaryMessenger: messenger)
        phone.onInbox = { [weak self] in self?.channel.invokeMethod("inboxChanged", arguments: nil) }
        channel.setMethodCallHandler { [weak self] call, result in
            guard let self else { return }
            do { try self.handle(call, result: result) }
            catch { result(FlutterError(code: "watch_unavailable", message: nil, details: nil)) }
        }
        phone.activate()
    }
    private func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) throws {
        switch call.method {
        case "activate": phone.activate(); result(nil)
        case "readPairingState": result(["generation": phone.inbox.generation])
        case "readInbox": result(phone.inbox.commands.map(\.dictionary))
        case "completeInboxItem":
            guard let value = call.arguments as? [String: Any] else { throw WatchError.invalid }
            let receipt = try JSONDecoder().decode(WatchReceipt.self, from: WatchProtocol.data(value))
            try phone.inbox.complete(receipt)
            try phone.send(receipt)
            result(nil)
        case "publishSnapshot":
            guard let value = call.arguments as? [String: Any] else { throw WatchError.invalid }
            try phone.publish(value); result(nil)
        case "rotateGeneration": try phone.rotate(); result(nil)
        default: result(FlutterMethodNotImplemented)
        }
    }
}
