import Foundation

protocol IRecipeRepository: Actor {
  func fetchRecipes() async throws -> RecipeFeedDTO?
}

actor HTTPDispatcher {
  nonisolated
  func dispatchRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
    try await URLSession.shared.data(for: request, delegate: nil)
  }
}

actor RecipeRepository: IRecipeRepository {
  private let requestProvider: IRequestProvider
  private let httpDispatcher: HTTPDispatcher
  
  init(requestProvider: IRequestProvider) {
    self.requestProvider = requestProvider
    self.httpDispatcher = HTTPDispatcher()
  }
  
  func fetchRecipes() async throws -> RecipeFeedDTO? {
    guard let request = requestProvider.provideRecipeFeedRequest() else {
      return nil
    }
    
    do {
      let (data, _) = try await httpDispatcher.dispatchRequest(request)
      return try decodeResponse(data)
    } catch {
      throw error
    }
  }
  
  private func decodeResponse<T: Codable>(_ data: Data) throws -> T? {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(T.self, from: data)
    } catch {
      throw error
    }
  }

}
