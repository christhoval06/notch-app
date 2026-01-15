import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    var privacyProtectionWindow: UIWindow?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    @objc func appWillResignActive() {
        guard privacyProtectionWindow == nil else { return }
        
        privacyProtectionWindow = UIWindow(frame: UIScreen.main.bounds)
        
        
        let vc = UIViewController()
        
        vc.view.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 1.0) // #121212
        
        
        if let logo = UIImage(named: "LaunchImage") {
            let imageView = UIImageView(image: logo)
            imageView.contentMode = .scaleAspectFit
            vc.view.addSubview(imageView)
            imageView.center = vc.view.center
        }
        
        privacyProtectionWindow?.rootViewController = vc
        privacyProtectionWindow?.windowLevel = .alert + 1
        privacyProtectionWindow?.makeKeyAndVisible()
    }
    
    @objc func appDidBecomeActive() {
        privacyProtectionWindow?.isHidden = true
        privacyProtectionWindow = nil
    }
}
