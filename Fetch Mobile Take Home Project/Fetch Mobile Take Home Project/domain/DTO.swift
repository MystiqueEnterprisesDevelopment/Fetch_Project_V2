import Foundation

struct RecipeFeedDTO: Codable {
  var recipes: [RecipeItemDTO]?
}

struct RecipeItemDTO: Codable {
  let cuisine: String
  let name: String
  let smallPhotoURL: String?
  let largePhotoURL: String?
  let uuid: String
  let sourceURL: String?
  let youtubeURL: String?
  
  enum CodingKeys: String, CodingKey {
    case smallPhotoURL = "photo_url_small"
    case cuisine, name, uuid
    case largePhotoURL = "photo_url_large"
    case sourceURL = "source_url"
    case youtubeURL = "youtube_url"
  }
}
