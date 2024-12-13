import Foundation

protocol IRecipeRepository: Actor {
  func fetchRecipes() async throws -> RecipeFeedDTO?
}

actor RecipeRepository: IRecipeRepository {
  private let requestProvider: IRequestProvider
  
  init(requestProvider: IRequestProvider) {
    self.requestProvider = requestProvider
  }
  
  func fetchRecipes() async throws -> RecipeFeedDTO? {
    guard let request = requestProvider.provideRecipeFeedRequest() else {
      return nil
    }
    
    do {
      let (data, _) = try await URLSession.shared.data(for: request)
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

extension URLSession {
    func data(for urlRequest: URLRequest) async throws -> (Data, URLResponse) {
        try await URLSession.shared.data(for: urlRequest, delegate: nil)
    }
}
