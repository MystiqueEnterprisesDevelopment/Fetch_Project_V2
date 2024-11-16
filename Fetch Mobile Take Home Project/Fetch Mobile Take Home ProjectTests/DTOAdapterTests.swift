import XCTest
@testable import Fetch_Mobile_Take_Home_Project

final class DTOAdapterTests: XCTestCase {
  var adapter_subject: DTOAdapter!
  
  override func setUpWithError() throws {
    adapter_subject = DTOAdapter()
  }
  
  func testSuccessfulAdapting() {
    let validDTO = RecipeItemDTO(cuisine: "valid-cuisine",
                            name: "valid-name",
                            smallPhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                            largePhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                            uuid: UUID().uuidString,
                            sourceURL: "https://www.bbc.co.uk/food/recipes/classic_carrot_cake_08513",
                            youtubeURL: "https://www.youtube.com/watch?v=WUpaOGghOdo")
    do {
      let adapted =  try adapter_subject.mapToDomainRecipeItem(dto: validDTO)
      
      XCTAssertNotNil(adapted.largePhotoURL)
      XCTAssertNotNil(adapted.smallPhotoURL)
      XCTAssertNotNil(adapted.youtubeURL)
      XCTAssertNotNil(adapted.sourceURL)

      XCTAssertEqual(adapted.name, "valid-name")
      XCTAssertEqual(adapted.cuisine, "valid-cuisine")
      XCTAssertNotNil(adapted.uuid)

    } catch {
      XCTAssertNil(error)
    }

  }
  
  func testInvalidYoutubeURL() {
    let invalid = RecipeItemDTO(cuisine: "valid-cuisine",
                            name: "valid-name",
                            smallPhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                            largePhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                            uuid: UUID().uuidString,
                            sourceURL: "https://www.bbc.co.uk/food/recipes/classic_carrot_cake_08513",
                            youtubeURL: "youtube")
    do {
      let adapted =  try adapter_subject.mapToDomainRecipeItem(dto: invalid)
      
      XCTAssertNotNil(adapted.largePhotoURL)
      XCTAssertNotNil(adapted.smallPhotoURL)
      XCTAssertNil(adapted.youtubeURL)
      XCTAssertNotNil(adapted.sourceURL)

      XCTAssertEqual(adapted.name, "valid-name")
      XCTAssertEqual(adapted.cuisine, "valid-cuisine")
      XCTAssertNotNil(adapted.uuid)

    } catch {
      XCTAssertNotNil(error)
    }
  }
  
  func testInvalidSourceURL() {
    let invalid = RecipeItemDTO(cuisine: "valid-cuisine",
                            name: "valid-name",
                            smallPhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                            largePhotoURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                            uuid: UUID().uuidString,
                            sourceURL: "source",
                            youtubeURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg")
    do {
      let adapted =  try adapter_subject.mapToDomainRecipeItem(dto: invalid)
      
      XCTAssertNotNil(adapted.largePhotoURL)
      XCTAssertNotNil(adapted.smallPhotoURL)
      XCTAssertNotNil(adapted.youtubeURL)
      XCTAssertNil(adapted.sourceURL)

      XCTAssertEqual(adapted.name, "valid-name")
      XCTAssertEqual(adapted.cuisine, "valid-cuisine")
      XCTAssertNotNil(adapted.uuid)

    } catch {
      XCTAssertNotNil(error)
    }
  }
  
  func testInvalidImageURL() {
    let invalid = RecipeItemDTO(cuisine: "valid-cuisine",
                            name: "valid-name",
                            smallPhotoURL: "img",
                            largePhotoURL: "img",
                            uuid: UUID().uuidString,
                            sourceURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg",
                            youtubeURL: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/9c7fa988-1bbe-4bed-9f1a-c9d4d8b311da/small.jpg")
    do {
      let adapted =  try adapter_subject.mapToDomainRecipeItem(dto: invalid)
      
      XCTAssertNil(adapted.largePhotoURL)
      XCTAssertNil(adapted.smallPhotoURL)
      XCTAssertNotNil(adapted.youtubeURL)
      XCTAssertNotNil(adapted.sourceURL)

      XCTAssertEqual(adapted.name, "valid-name")
      XCTAssertEqual(adapted.cuisine, "valid-cuisine")
      XCTAssertNotNil(adapted.uuid)

    } catch {
      XCTAssertNotNil(error)
    }
  }

}
