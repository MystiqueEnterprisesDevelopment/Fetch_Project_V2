import UIKit

typealias VoidCompletion = () -> ()

//Imported from personal project
class DispatchManager: NSObject {
  class func executeOnMainThread(_ completion: @escaping VoidCompletion) {
    DispatchQueue.main.async { completion() }
  }
  
  class func executeOnMainThread(withDelay delay: TimeInterval, _ completion: @escaping VoidCompletion) {
    DispatchQueue.main.asyncAfter(deadline: (.now() + delay), execute: completion)
  }
}
