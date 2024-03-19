import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        self.window = UIWindow()
        guard window != nil else {
            return false
        }
        
        window?.rootViewController = FirstViewController()
        window?.makeKeyAndVisible()

        return true
    }
}
