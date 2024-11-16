import SwiftUI

class MainRouter {
  var navigationController: UINavigationController?
  private let factory: Factory
  
  init(navigation: UINavigationController, factory: Factory) {
    self.navigationController = navigation
    self.factory = factory
  }
  
  func startFlow() {
    guard let navigationController else {
      return
    }
    
    DispatchManager.executeOnMainThread {
      let loadingScreen = self.factory.makeLoadingScreen(withRouter: self)
      navigationController.setViewControllers([loadingScreen], animated: true)
    }
  }
  
  func routeToRecipeFeed(feed: RecipeFeed) {
    guard let navigationController else {
      return
    }
    
    DispatchManager.executeOnMainThread {
      let feed = self.factory.makeRecipeFeedViewController(feed: feed, withRouter: self)
      navigationController.setViewControllers([feed], animated: false)
    }
  }
  
  func routeToRecipeDetail(recipe: RecipeItem) {
    guard let navigationController else {
      return
    }
    
    DispatchManager.executeOnMainThread {
      let detail = self.factory.makeRecipeDetailViewController(recipe: recipe, router: self)
      navigationController.pushViewController(detail, animated: true)
    }
  }
  
  func routeToWebsite(withURL url: URL) {
    DispatchManager.executeOnMainThread {
      if UIApplication.shared.canOpenURL(url) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
      }
    }
  }
  
}

