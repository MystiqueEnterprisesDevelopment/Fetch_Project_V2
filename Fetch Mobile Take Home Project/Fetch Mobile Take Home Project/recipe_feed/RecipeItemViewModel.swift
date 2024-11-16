import SwiftUI

class RecipeItemViewModel: ObservableObject, Identifiable {
  let recipeItem: RecipeItem
  
  var name: String {
    return recipeItem.name
  }
  
  var cuisineType: String {
    return recipeItem.cuisine
  }
  
  var id: Int {
    return recipeItem.uuid.hashValue
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
  
  @Published var overrideSeeMore: Bool = false
  @Published var isThumbnailEnabled: Bool = true

  var thumbnailImageURL: URL? {
    return recipeItem.smallPhotoURL
  }
  
  init(recipeItem: RecipeItem) {
    self.recipeItem = recipeItem
  }
  
  func disableSeeMore(_ isDisabled: Bool) {
    self.overrideSeeMore = isDisabled
  }
  
  func disableThumbnail(_ isDisabled: Bool) {
    self.isThumbnailEnabled = !isDisabled
  }
}
