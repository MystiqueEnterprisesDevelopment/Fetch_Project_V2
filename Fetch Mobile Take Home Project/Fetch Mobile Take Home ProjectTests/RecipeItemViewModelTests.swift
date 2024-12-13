import XCTest
@testable import Fetch_Mobile_Take_Home_Project

@MainActor
final class RecipeItemViewModelTests: XCTestCase {
  var subject: RecipeItemViewModel!
  
  func testBasicRecipe() {
    setUp { _ in
      let item = RecipeItem(cuisine: "cuisine", name: "name", uuid: "uuid")
      self.subject = RecipeItemViewModel(recipeItem: item)
    }
    
    XCTAssertEqual(subject.cuisineType, "cuisine")
    XCTAssertEqual(subject.name, "name")
    XCTAssertEqual(subject.id, "uuid".hashValue)
    XCTAssertFalse(subject.showViewDetail)
  
  }
  
  func testFullRecipe() {
    setUp { _ in
      let item = RecipeItem(cuisine: "cuisine",
                            name: "name",
                            smallPhotoURL: URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/small.jpg"),
                            largePhotoURL: URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/photos/f18384e7-3da7-4714-8f09-bbfa0d2c8913/large.jpg"),
                            uuid: "uuid",
                            sourceURL: URL(string: "https://www.bbcgoodfood.com/recipes/1837/canadian-butter-tarts"),
                            youtubeURL: URL(string: "https://www.youtube.com/watch?v=WUpaOGghOdo")
      )
      self.subject = RecipeItemViewModel(recipeItem: item)
    }
    
    XCTAssertEqual(subject.cuisineType, "cuisine")
    XCTAssertEqual(subject.name, "name")
    XCTAssertEqual(subject.id, "uuid".hashValue)
    XCTAssertTrue(subject.showViewDetail)
  }
  
}
