import SwiftUI

class RecipeDetailViewModel: ObservableObject {
  @Published var recipeItemViewModel: RecipeItemViewModel
  
  private let router: MainRouter?
  
  init(recipe: RecipeItemViewModel, router: MainRouter?) {
    self.recipeItemViewModel = recipe
    self.router = router
    configureInitialState()
  }
  
  func configureInitialState() {
    recipeItemViewModel.disableSeeMore(true)
    
    if largeImageURL() != nil {
      recipeItemViewModel.disableThumbnail(true)
    }
  }
  
  func recipeSourceURL() -> URL? {
    return recipeItemViewModel.recipeItem.sourceURL
  }
  
  func largeImageURL() -> URL? {
    return recipeItemViewModel.recipeItem.largePhotoURL
  }
  
  func youtubeURL() -> URL? {
    return recipeItemViewModel.recipeItem.youtubeURL
  }
  
  func showWebpage(url: URL) {
    router?.routeToWebsite(withURL: url)
  }
}
