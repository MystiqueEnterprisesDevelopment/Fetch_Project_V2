import SwiftUI

@MainActor
final class LoadingViewModel: ObservableObject {
  private var router: MainRouter?
  private let interactor: IRecipeInteractor
  
  @Published var isLoading: Bool = true
  @Published var isErrored: Bool = false
  
  init(interactor: IRecipeInteractor, router: MainRouter?) {
    self.router = router
    self.interactor = interactor
  }
  
  func startLoading() async {
    updateState(isLoading: true, isErrored: false)
  
    do {
      let recipes = try await interactor.loadRecipes()
      updateState(isLoading: false, isErrored: false)
      router?.routeToRecipeFeed(feed: recipes)
    } catch {
      updateState(isLoading: false, isErrored: true)
    }
  
  }
  
  func updateState(isLoading: Bool, isErrored: Bool) {
    self.isErrored = isErrored
    self.isLoading = isLoading
  }
  
  func retryLoading() async {
    await startLoading()
  }
}

