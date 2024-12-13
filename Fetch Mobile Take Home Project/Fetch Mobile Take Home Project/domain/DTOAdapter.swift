import Foundation

enum MappingError: Error {
  case domainMappingError
}

struct DTOAdapter {
  func mapToDomainRecipeFeed(dto: RecipeFeedDTO) throws -> RecipeFeed {
    guard let items = dto.recipes else {
      return RecipeFeed(recipes: [])
    }
    
    var adaptedRecipes: [RecipeItem]
    
    do {
      adaptedRecipes = try items.map { dto in
        return try mapToDomainRecipeItem(dto: dto)
      }
    } catch {
      throw MappingError.domainMappingError
    }
    
    return RecipeFeed(recipes: adaptedRecipes)
  }
  
  func mapToDomainRecipeItem(dto: RecipeItemDTO) throws -> RecipeItem {
    var smallPhotoURL: URL?
    var largePhotoURL: URL?
    var sourceURL: URL?
    var youtubeURL: URL?
    
    if let smallPhotoStr = dto.smallPhotoURL {
      if let smallURL = URL(string: smallPhotoStr) {
        smallPhotoURL = smallURL
      } else {
        throw MappingError.domainMappingError
      }
    }
    
    if let largePhotoStr = dto.largePhotoURL {
      if let largeURL = URL(string: largePhotoStr), isValidURL(largeURL) {
        largePhotoURL = largeURL
      } else {
        throw MappingError.domainMappingError
      }
    }
    
    if let sourceStr = dto.sourceURL {
      if let source = URL(string: sourceStr), isValidURL(source) {
        sourceURL = source
      } else {
        throw MappingError.domainMappingError
      }
    }
    
    if let youtubeStr = dto.youtubeURL {
      if let youtube = URL(string: youtubeStr), isValidURL(youtube) {
        youtubeURL = youtube
      } else {
        throw MappingError.domainMappingError
      }
    }
    
    var item = RecipeItem(cuisine: dto.cuisine, name: dto.name, uuid: dto.uuid)
    item.smallPhotoURL = smallPhotoURL
    item.largePhotoURL = largePhotoURL
    item.sourceURL = sourceURL
    item.youtubeURL = youtubeURL
    return item
  }
  
  private func isValidURL(_ url: URL) -> Bool {
    return url.isFileURL || (url.host != nil && url.scheme != nil)
  }
}
