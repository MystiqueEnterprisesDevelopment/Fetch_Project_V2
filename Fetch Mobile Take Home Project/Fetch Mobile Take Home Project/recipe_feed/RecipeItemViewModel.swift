import SwiftUI

@MainActor
class RecipeItemViewModel: ObservableObject, Identifiable {
  private let recipeItem: RecipeItem
  let id: Int
  
  @Published var overrideSeeMore: Bool = false
  @Published var isThumbnailEnabled: Bool = true
  
  var name: String {
    return recipeItem.name
  }
  
  var cuisineType: String {
    return recipeItem.cuisine
  }
    
  var showViewDetail: Bool {
    if recipeItem.largePhotoURL != nil {
      return true
    }
    
    if recipeItem.sourceURL != nil {
      return true
    }
    
    if recipeItem.youtubeURL != nil {
      return true
    }
    
    return false
  }

  var thumbnailImageURL: URL? {
    return recipeItem.smallPhotoURL
  }
  
  init(recipeItem: RecipeItem) {
    self.recipeItem = recipeItem
    self.id = recipeItem.uuid.hashValue
  }
  
  func disableSeeMore(_ isDisabled: Bool) {
    self.overrideSeeMore = isDisabled
  }
  
  func disableThumbnail(_ isDisabled: Bool) {
    self.isThumbnailEnabled = !isDisabled
  }
  
  func recipe() -> RecipeItem {
    return recipeItem
  }
}
