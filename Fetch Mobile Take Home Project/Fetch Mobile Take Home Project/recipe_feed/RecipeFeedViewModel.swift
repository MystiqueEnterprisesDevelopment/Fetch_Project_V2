import SwiftUI

@MainActor
class RecipeFeedViewModel: ObservableObject {
  @Published var recipes: [RecipeItemViewModel] = []
  @Published var isLoading: Bool = false
  
  private let interactor: IRecipeInteractor
  private var router: MainRouter?
  
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
    do {
      updateState(isLoading: true)
      let items = try await interactor.loadRecipes()
      updateRecipes(recipes: items.recipes)
      updateState(isLoading: false)
    } catch {
      updateRecipes(recipes: [])
      updateState(isLoading: false)
    }
  }
  
  private func updateRecipes(recipes: [RecipeItem]) {
    let vms = recipes.map { item_i in
      return RecipeItemViewModel(recipeItem: item_i)
    }
    self.recipes = vms
  }
  
  private func updateState(isLoading: Bool) {
    self.isLoading = isLoading
  }
  
  func showRecipeDetail(forRecipe recipe: RecipeItemViewModel) {
    router?.routeToRecipeDetail(recipe: recipe.recipe())
  }
}
