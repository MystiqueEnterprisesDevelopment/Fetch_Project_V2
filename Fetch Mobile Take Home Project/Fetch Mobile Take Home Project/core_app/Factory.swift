import SwiftUI

class Factory {
  func makeMainRouter() -> MainRouter {
    let nav = UINavigationController()
    return MainRouter(navigation: nav, factory: self)
  }
  
  private func makeRecipeRepository() -> IRecipeRepository {
    return RecipeRepository(requestProvider: RequestProvider())
  }
  
  private func makeRecipeInteractor() -> IRecipeInteractor {
    return RecipeInteractor(repository: makeRecipeRepository())
  }
  
  func makeLoadingScreen(withRouter router: MainRouter) -> UIViewController {
    let interactor = makeRecipeInteractor()
    let vm = LoadingViewModel(interactor: interactor, router: router)
    return UIHostingController(rootView: LoadingView(viewModel: vm))
  }
  
  func makeRecipeFeedViewController(feed: RecipeFeed, withRouter router: MainRouter) -> UIViewController {
    let interactor = makeRecipeInteractor()
    let vm = RecipeFeedViewModel(initialFeed: feed, interactor: interactor, router: router)
    let vc = UIHostingController(rootView: RecipeFeedView(viewModel: vm))
    vc.title = "Recipes"
    return vc
  }
  
  func makeRecipeDetailViewController(recipe: RecipeItem, router: MainRouter) -> UIViewController {
    let itemVM = RecipeItemViewModel(recipeItem: recipe)
    let detailVM = RecipeDetailViewModel(recipe: itemVM, router: router)
    let vc = UIHostingController(rootView: RecipeDetailView(viewModel: detailVM))
    vc.title = itemVM.name
    return vc
  }

}
