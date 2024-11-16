import SwiftUI

class LoadingViewModel: ObservableObject {
  weak var router: MainRouter?
  private let interactor: IRecipeInteractor?
  
  @Published var isLoading: Bool = false
  @Published var isErrored: Bool = false
  
  init(interactor: IRecipeInteractor?, router: MainRouter?) {
    self.router = router
    self.interactor = interactor
  }
  
  func startLoading() {
    updateState(isLoading: true, isErrored: false)
    
    guard let interactor else {
      updateState(isLoading: false, isErrored: true)
      return
    }
    
    Task {
      do {
        let recipes = try await interactor.loadRecipes()
        updateState(isLoading: false, isErrored: false)
        router?.routeToRecipeFeed(feed: recipes)
      } catch {
        updateState(isLoading: false, isErrored: true)
      }
    }
    
  }
  
  func updateState(isLoading: Bool, isErrored: Bool) {
    DispatchManager.executeOnMainThread {
      self.isErrored = isErrored
      self.isLoading = isLoading
    }
  }
  
  func retryLoading() {
    startLoading()
  }
}

