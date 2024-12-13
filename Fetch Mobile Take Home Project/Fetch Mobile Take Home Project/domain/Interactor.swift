import Foundation

protocol IRecipeInteractor: Actor {
  func loadRecipes() async throws -> RecipeFeed
}

actor RecipeInteractor: IRecipeInteractor {
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



