import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        let configuration = UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
    }
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var installChannel: FlutterMethodChannel?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let controller = FlutterViewController(project: nil, nibName: nil, bundle: nil)
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.rootViewController = controller
        window.makeKeyAndVisible()

        // The preview has no plugin registration or access to the parent's storage.
        installChannel = FlutterMethodChannel(
            name: "dev.christhoval.apps.notch/app_clip",
            binaryMessenger: controller.binaryMessenger
        )
        installChannel?.setMethodCallHandler { call, result in
            guard call.method == "openAppStore" else {
                result(FlutterMethodNotImplemented)
                return
            }
            guard let value = call.arguments as? String,
                  let url = URL(string: value), url.scheme == "https",
                  url.host == "apps.apple.com" else {
                result(FlutterError(code: "invalid_url", message: nil, details: nil))
                return
            }
            UIApplication.shared.open(url, options: [:]) { opened in
                if opened {
                    result(nil)
                } else {
                    result(FlutterError(code: "open_failed", message: nil, details: nil))
                }
            }
        }
    }
}
