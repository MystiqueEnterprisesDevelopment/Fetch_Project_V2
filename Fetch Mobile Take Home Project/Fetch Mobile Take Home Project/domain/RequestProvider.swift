import Foundation

protocol IRequestProvider {
  func provideRecipeFeedRequest() -> URLRequest?
}

class RequestProvider: IRequestProvider {
  func provideRecipeFeedRequest() -> URLRequest? {
    let urlStr = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    guard let url = URL(string: urlStr) else {
      return nil
    }

    return URLRequest(url: url)
  }
}

