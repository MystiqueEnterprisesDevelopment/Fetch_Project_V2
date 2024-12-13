import XCTest
@testable import Fetch_Mobile_Take_Home_Project

final class MockRequestProvider: IRequestProvider, Sendable {
  let url: URL?
  
  init(mockURL: URL?) {
    self.url = mockURL
  }
  
  func provideRecipeFeedRequest() -> URLRequest? {
    guard let url else {
      return nil
    }
    
    return URLRequest(url: url)
  }
}

final class RepositoryTests: XCTestCase {
  var subject: RecipeRepository!
  
  func testGoodResponse() {
    setUp { _ in
      let mockProvider = MockRequestProvider(mockURL: URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"))
      self.subject = RecipeRepository(requestProvider: mockProvider)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("subject should not be nil")
      }
      
      do {
       let recipeFeedDto = try await subject.fetchRecipes()
        
        XCTAssertNotNil(recipeFeedDto)
        XCTAssertTrue(recipeFeedDto?.recipes != nil)
        
      } catch {
        XCTAssertNil(error)
      }
    }
  }
  
  func testMalformedResponse() {
    setUp { _ in
      let mockProvider = MockRequestProvider(mockURL: URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"))
      self.subject = RecipeRepository(requestProvider: mockProvider)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("subject should not be nil")
      }
      
      do {
       let recipeFeedDto = try await subject.fetchRecipes()
        
        XCTAssertNil(recipeFeedDto)
        XCTAssertTrue(recipeFeedDto?.recipes == nil)
        
      } catch {
        XCTAssertNotNil(error)
      }
    }
  }
  
  func testEmptyResponse() {
    setUp { _ in
      let mockProvider = MockRequestProvider(mockURL: URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"))
      self.subject = RecipeRepository(requestProvider: mockProvider)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("subject should not be nil")
      }
      
      do {
       let recipeFeedDto = try await subject.fetchRecipes()
        
        XCTAssertNotNil(recipeFeedDto)
        XCTAssertTrue(recipeFeedDto?.recipes != nil)
        XCTAssertTrue(recipeFeedDto!.recipes!.isEmpty)
        
      } catch {
        XCTAssertNotNil(error)
      }
    }
  }

}
