import SwiftUI

@MainActor
final class MainRouter {
  private let navigationController: UINavigationController
  private let factory: Factory
  
  init(navigation: UINavigationController, factory: Factory) {
    self.navigationController = navigation
    self.factory = factory
  }
  
  func navigation() -> UINavigationController {
    return navigationController
  }
  
  func startFlow() {
    let loadingScreen = self.factory.makeLoadingScreen(withRouter: self)
    navigationController.setViewControllers([loadingScreen], animated: true)
  }
  
  func routeToRecipeFeed(feed: RecipeFeed) {
    let feed = self.factory.makeRecipeFeedViewController(feed: feed, withRouter: self)
    navigationController.setViewControllers([feed], animated: false)
  }
  
  func routeToRecipeDetail(recipe: RecipeItem) {
    let detail = self.factory.makeRecipeDetailViewController(recipe: recipe, router: self)
    navigationController.pushViewController(detail, animated: true)
  }
  
  func routeToWebsite(withURL url: URL) {
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
  }
  
}

