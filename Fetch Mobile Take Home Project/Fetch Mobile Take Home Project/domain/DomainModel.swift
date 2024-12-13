import Foundation

struct RecipeFeed {
  var recipes: [RecipeItem] = []
  
  init(recipes: [RecipeItem]) {
    self.recipes = recipes
  }
  
  func hasRecipes() -> Bool {
    return !recipes.isEmpty
  }
}

struct RecipeItem {
  var cuisine: String
  var name: String
  var smallPhotoURL: URL?
  var largePhotoURL: URL?
  let uuid: String
  var sourceURL: URL?
  var youtubeURL: URL?
  
  init(cuisine: String, name: String, smallPhotoURL: URL? = nil, largePhotoURL: URL? = nil, uuid: String, sourceURL: URL? = nil, youtubeURL: URL? = nil) {
    self.cuisine = cuisine
    self.name = name
    self.smallPhotoURL = smallPhotoURL
    self.largePhotoURL = largePhotoURL
    self.uuid = uuid
    self.sourceURL = sourceURL
    self.youtubeURL = youtubeURL
  }
}

