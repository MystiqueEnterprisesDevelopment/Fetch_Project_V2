import XCTest
@testable import Fetch_Mobile_Take_Home_Project

@MainActor
final class RecipeFeedViewModelTests: XCTestCase {
  var subject: RecipeFeedViewModel!
  
  func testEmptyInitialFeed() {
    setUp { _ in
      let mock = MockInteractor(returnMock: RecipeFeed(recipes: []))
      let emptyInitial = RecipeFeed(recipes: [])
      self.subject = RecipeFeedViewModel(initialFeed: emptyInitial,
                                         interactor: mock,
                                         router: nil)
    }
    
    XCTAssertFalse(subject.hasRecipes())
    XCTAssertFalse(subject.isLoading)
  }
  
  func testErroredReload() {
    setUp { _ in
      let mock = MockInteractor(returnMock: nil)
      let emptyInitial = RecipeFeed(recipes: [])
      self.subject = RecipeFeedViewModel(initialFeed: emptyInitial,
                                         interactor: mock,
                                         router: nil)
    }
        
    XCTAssertFalse(subject.hasRecipes())
    XCTAssertFalse(subject.isLoading)
    
  }
  
  func testPopulatedFeed() {
    setUp { _ in
      let populated = RecipeFeed(recipes: [
        RecipeItem(cuisine: "cuisine 1", name: "name 1", uuid: UUID().uuidString),
        RecipeItem(cuisine: "cuisine 2", name: "name 2", uuid: UUID().uuidString),
      ])

      let mockInt = MockInteractor(returnMock: populated)
      
      self.subject = RecipeFeedViewModel(initialFeed: populated,
                                         interactor: mockInt,
                                         router: nil)

    }
    
    XCTAssertTrue(subject.hasRecipes())
    XCTAssertFalse(subject.isLoading)
    XCTAssertEqual(subject.recipes.count, 2)
  }
}
