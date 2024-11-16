import XCTest
@testable import Fetch_Mobile_Take_Home_Project


final class RequestProviderTest: XCTestCase {
  var subject: IRequestProvider!
  
  override func setUpWithError() throws {
    subject = RequestProvider()
  }
  
  func testRequest() {
    let req = subject.provideRecipeFeedRequest()
    
    XCTAssertNotNil(req)
    XCTAssertEqual(req?.httpMethod, "GET")
    XCTAssertEqual(req?.url?.absoluteString, "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
  }

}
