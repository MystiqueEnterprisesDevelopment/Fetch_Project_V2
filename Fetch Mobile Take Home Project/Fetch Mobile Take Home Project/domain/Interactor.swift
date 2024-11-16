import Foundation

protocol IRecipeRepository {
  func fetchRecipes() async throws -> RecipeFeedDTO?
}

protocol IRecipeInteractor {
  func loadRecipes() async throws -> RecipeFeed
}

protocol IRequestProvider {
  func provideRecipeFeedRequest() -> URLRequest?
}

struct RecipeInteractor: IRecipeInteractor {
  private let repository: IRecipeRepository
  
  init(repository: IRecipeRepository) {
    self.repository = repository
  }
  
  func loadRecipes() async throws -> RecipeFeed {
    let adapter = DTOAdapter()
    
    do {
      guard let recipeDTO = try await repository.fetchRecipes() else {
        throw MappingError.domainMappingError
      }
      
      return try adapter.mapToDomainRecipeFeed(dto: recipeDTO)
    } catch {
      throw error
    }

  }
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

class RequestProvider: IRequestProvider {
  func provideRecipeFeedRequest() -> URLRequest? {
    let urlStr = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    guard let url = URL(string: urlStr) else {
      return nil
    }

    return URLRequest(url: url)
  }
}

