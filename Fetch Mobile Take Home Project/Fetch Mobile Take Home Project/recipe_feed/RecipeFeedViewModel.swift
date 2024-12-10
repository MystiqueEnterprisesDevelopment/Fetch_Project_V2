import SwiftUI

@MainActor
class RecipeFeedViewModel: ObservableObject {
  @Published var recipes: [RecipeItemViewModel] = []
  @Published var isLoading: Bool = false

  private let interactor: IRecipeInteractor
  private var router: MainRouter?
  
//  var hasRecipes: Bool {
//    return !recipes.isEmpty
//  }
  
  
  func hasRecipes() -> Bool {
    return !recipes.isEmpty
  }
  
  init(initialFeed: RecipeFeed, interactor: IRecipeInteractor, router: MainRouter?) {
    self.interactor = interactor
    self.recipes = initialFeed.recipes.map({ recipe_i in
      return RecipeItemViewModel(recipeItem: recipe_i)
    })
    self.router = router
  }
  
  func reloadRecipes() async {
    updateState(isLoading: true)
    
    //Task {
      do {
        let items = try await interactor.loadRecipes()
        self.updateRecipes(recipes: items.recipes)
        updateState(isLoading: false)
      } catch {
        self.updateRecipes(recipes: [])
        updateState(isLoading: false)
      }
   // }
  }
  
  private func updateRecipes(recipes: [RecipeItem]) {
    DispatchManager.executeOnMainThread {
      let vms = recipes.map { item_i in
        return RecipeItemViewModel(recipeItem: item_i)
      }
      self.recipes = vms
    }
  }
  
  func updateState(isLoading: Bool) {
    DispatchManager.executeOnMainThread {
      self.isLoading = isLoading
    }
  }
  
  func showRecipeDetail(forRecipe recipe: RecipeItemViewModel) {
    router?.routeToRecipeDetail(recipe: recipe.recipeItem)
  }
}
