import SwiftUI

@MainActor
class RecipeDetailViewModel: ObservableObject {
  @Published var recipeItemViewModel: RecipeItemViewModel
  
  private let router: MainRouter?
  
  init(recipe: RecipeItemViewModel, router: MainRouter?) {
    self.recipeItemViewModel = recipe
    self.router = router
    configureInitialState()
  }
  
  private func configureInitialState() {
    recipeItemViewModel.disableSeeMore(true)
    
    if largeImageURL() != nil {
      recipeItemViewModel.disableThumbnail(true)
    }
  }
  
  func recipeSourceURL() -> URL? {
    return recipeItemViewModel.recipe().sourceURL
  }
  
  func largeImageURL() -> URL? {
    return recipeItemViewModel.recipe().largePhotoURL
  }
  
  func youtubeURL() -> URL? {
    return recipeItemViewModel.recipe().youtubeURL
  }
  
  func showWebpage(url: URL) {
    router?.routeToWebsite(withURL: url)
  }
}
