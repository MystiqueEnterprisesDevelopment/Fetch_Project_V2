import XCTest
@testable import Fetch_Mobile_Take_Home_Project

enum MockError: Error {
  case mock
}

actor MockInteractor: IRecipeInteractor {
  let mock: RecipeFeed?
  
  init(returnMock: RecipeFeed?) {
    self.mock = returnMock
  }
  
  func loadRecipes() async throws -> RecipeFeed {
    if mock == nil {
      throw MockError.mock
    } else {
      return mock!
    }
  }
  
}

@MainActor
final class LoadingViewModelTests: XCTestCase {
  private var subject: LoadingViewModel!
  
  func testEmpty() {
    setUp { _ in
      let mock = MockInteractor(returnMock: RecipeFeed(recipes: []))
      self.subject = LoadingViewModel(interactor: mock, router: nil)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("")
      }
      await subject.startLoading()
      XCTAssertFalse(subject.isErrored)
      XCTAssertFalse(subject.isLoading)
    }
  }
  
  func testError() {
    setUp { _ in
      let mock = MockInteractor(returnMock: nil)
      self.subject = LoadingViewModel(interactor: mock, router: nil)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("")
      }
      await subject.startLoading()
      XCTAssertFalse(subject.isErrored)
      XCTAssertFalse(subject.isLoading)
    }
  }
  
  func testNotEmpty() {
    setUp { _ in
      let mock = MockInteractor(returnMock: RecipeFeed(recipes: [
        RecipeItem(cuisine: "cuisine", name: "name", uuid: "uuid")
      ]))
      
      self.subject = LoadingViewModel(interactor: mock, router: nil)
    }
    
    Task { [subject] in
      guard let subject = subject else {
        return XCTFail("")
      }
      await subject.startLoading()
      XCTAssertFalse(subject.isErrored)
      XCTAssertFalse(subject.isLoading)
    }
  }
  
}
