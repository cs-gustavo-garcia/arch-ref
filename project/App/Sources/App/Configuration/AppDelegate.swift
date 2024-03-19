import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    var fisrtCoordinator : FirstCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController: UINavigationController = .init()
        fisrtCoordinator = FirstCoordinator(navigationController: navigationController)
        window?.rootViewController = navigationController
        fisrtCoordinator?.start()
        window?.makeKeyAndVisible()
        return true
    }
}
