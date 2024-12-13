import XCTest
@testable import Fetch_Mobile_Take_Home_Project

actor MockRepository: IRecipeRepository {
  var mockedRecipes: RecipeFeedDTO?
  
  init(recipes: RecipeFeedDTO?) {
    self.mockedRecipes = recipes
  }
  
  func fetchRecipes() async throws -> RecipeFeedDTO? {
    return mockedRecipes
  }
}

final class InteractorTests: XCTestCase {
  var subject: RecipeInteractor!

  func testEmpty() {
    setUp { err in
      let mock = MockRepository(recipes: RecipeFeedDTO(recipes: []))
      self.subject = RecipeInteractor(repository: mock)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("subject should not be nil")
      }
      
      do {
        let feed = try await subject.loadRecipes()
        XCTAssertFalse(feed.hasRecipes())
      } catch {
        XCTAssertNil(error)
      }
    }
   
  }
  
  func testNil() {
    setUp { err in
      let mock = MockRepository(recipes: nil)
      self.subject = RecipeInteractor(repository: mock)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("subject should not be nil")
      }
      
      do {
        let feed = try await subject.loadRecipes()
        XCTAssertNil(feed)
      } catch {
        XCTAssertNotNil(error)
      }
    }
  }
  
  func testNotEmpty() {
    setUp { err in
      var mockRecipes: [RecipeItemDTO] = []
      for _ in 0..<10 {
        mockRecipes.append(RecipeItemDTO(cuisine: "cuisine",
                                         name: "name",
                                         smallPhotoURL: "https://google.com",
                                         largePhotoURL: "https://google.com",
                                         uuid: UUID().uuidString,
                                         sourceURL: "https://google.com",
                                         youtubeURL: "https://google.com"))
      }
      
      let mock = MockRepository(recipes: RecipeFeedDTO(recipes: mockRecipes))
      self.subject = RecipeInteractor(repository: mock)
    }
    
    Task { [subject] in
      
      guard let subject = subject else {
        return XCTFail("subject should not be nil")
      }
      
      do {
        let feed = try await subject.loadRecipes()
        
        XCTAssertTrue(feed.hasRecipes())
        XCTAssertTrue(feed.recipes.count == 10)
        
      } catch {
        XCTAssertNotNil(error)
      }
    }
  }
  
}
