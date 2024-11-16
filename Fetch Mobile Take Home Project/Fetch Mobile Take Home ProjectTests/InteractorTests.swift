import XCTest
@testable import Fetch_Mobile_Take_Home_Project

class MockRepository: IRecipeRepository {
  var mockedRecipes: RecipeFeedDTO?
  
  init(recipes: RecipeFeedDTO?) {
    self.mockedRecipes = recipes
  }
  
  func fetchRecipes() async throws -> RecipeFeedDTO? {
    return mockedRecipes
  }
}

final class InteractorTests: XCTestCase {
  var interactor_subject: RecipeInteractor!

  func testEmpty() {
    setUp { err in
      let mock = MockRepository(recipes: RecipeFeedDTO(recipes: []))
      self.interactor_subject = RecipeInteractor(repository: mock)
    }
    
    Task {
      do {
        let feed = try await interactor_subject.loadRecipes()
        XCTAssertFalse(feed.hasRecipes())
      } catch {
        XCTAssertNil(error)
      }
    }
   
  }
  
  func testNil() {
    setUp { err in
      let mock = MockRepository(recipes: nil)
      self.interactor_subject = RecipeInteractor(repository: mock)
    }
    
    Task {
      do {
        let feed = try await interactor_subject.loadRecipes()
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
      self.interactor_subject = RecipeInteractor(repository: mock)
    }
    
    Task {
      do {
        let feed = try await interactor_subject.loadRecipes()
        
        XCTAssertTrue(feed.hasRecipes())
        XCTAssertTrue(feed.recipes.count == 10)
        
      } catch {
        XCTAssertNotNil(error)
      }
    }
  }
  
}
