import SwiftUI

class RecipeDetailViewModel: ObservableObject {
  @Published var recipeItemViewModel: RecipeItemViewModel
  
  private let router: MainRouter?
  
  init(recipe: RecipeItemViewModel, router: MainRouter?) {
    self.recipeItemViewModel = recipe
    self.router = router
    configureInitialState()
  }
  
  func configureInitialState() {
    recipeItemViewModel.disableSeeMore(true)
    
    if largeImageURL() != nil {
      recipeItemViewModel.disableThumbnail(true)
    }
  }
  
  func recipeSourceURL() -> URL? {
    return recipeItemViewModel.recipeItem.sourceURL
  }
  
  func largeImageURL() -> URL? {
    return recipeItemViewModel.recipeItem.largePhotoURL
  }
  
  func youtubeURL() -> URL? {
    return recipeItemViewModel.recipeItem.youtubeURL
  }
  
  func showWebpage(url: URL) {
    router?.routeToWebsite(withURL: url)
  }
}

struct RecipeDetailView: View {
  @ObservedObject var viewModel: RecipeDetailViewModel
  
  var body: some View {
    ScrollView(.vertical) {
      VStack(alignment: .leading, spacing: 16.0, content: {
        if let largeImg = viewModel.largeImageURL() {
          LargeRecipeImage(url: largeImg)
        }
        
        RecipeItemView(viewModel: viewModel.recipeItemViewModel)
        
        if let videoURL = viewModel.youtubeURL() {
          videoPlayerSection(videoURL: videoURL)
        }
        
        if let source = viewModel.recipeSourceURL() {
          PrimaryCTA(title: "View recipe source") {
            viewModel.showWebpage(url: source)
          }
        }
        
      })
      .padding()
    }
    
  }
  
  @ViewBuilder
  func videoPlayerSection(videoURL: URL) -> some View {
    VStack(alignment: .leading, content: {
      Text("Related video")
        .font(Font.system(size: 18.0, weight: .bold))
      HStack(content: {
        Image(systemName: "play.circle")
          .resizable()
          .frame(width: 30, height: 30, alignment: .leading)
        TertiaryCTA(title: "Watch video") {
          viewModel.showWebpage(url: videoURL)
        }
        
      })
    })
  }
  
  @ViewBuilder
  func LargeRecipeImage(url: URL) -> some View {
    AsyncCachableImage(url: url)
      .frame(maxWidth: 350, maxHeight: 350)
  }
}

