import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        self.window = UIWindow()
        guard window != nil else {
            return false
        }

        let vc = UIViewController()
        window?.rootViewController = vc
        vc.view.backgroundColor = .systemGreen

        window?.makeKeyAndVisible()

        return true
    }
}
