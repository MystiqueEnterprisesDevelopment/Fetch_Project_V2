import Foundation

protocol IRecipeRepository {
  func fetchRecipes() async throws -> RecipeFeedDTO?
}

class RecipeRepository: IRecipeRepository {
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
  
  func decodeResponse<T: Codable>(_ data: Data) throws -> T? {
    let decoder = JSONDecoder()
    do {
      return try decoder.decode(T.self, from: data)
    } catch {
      throw error
    }
  }
  
}
