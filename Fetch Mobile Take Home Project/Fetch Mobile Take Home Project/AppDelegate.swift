import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var router: MainRouter?
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    guard !isTesting() else {
      return false
    }
    
    let factory = Factory()
    let router = factory.makeMainRouter()
    
    router.startFlow()
    
    self.router = router
    self.window = UIWindow(frame: UIScreen.main.bounds)
    
    guard let window = self.window else {
      return false
    }
    
    window.rootViewController = router.navigation()
    window.makeKeyAndVisible()
  
    return true
  }
  
  private func isTesting() -> Bool {
   return ProcessInfo.processInfo.environment["XCInjectBundleInto"] != nil
  }
}

