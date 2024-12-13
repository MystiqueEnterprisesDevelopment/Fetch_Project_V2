import SwiftUI

struct RecipeItemView: View {
  @StateObject var viewModel: RecipeItemViewModel
  
  var seeMoreAction: ((RecipeItemViewModel) -> ())?
  
  var body: some View {
    VStack(alignment: .trailing, content: {
      
      HStack(alignment: .top, content: {
        if let img = viewModel.thumbnailImageURL, viewModel.isThumbnailEnabled  {
          cacheableURLImage(url: img)
        }
        header()
      }).frame(maxWidth: .infinity)
      
      if viewModel.showViewDetail && !viewModel.overrideSeeMore {
        TertiaryCTA(title: "See more") {
          seeMoreAction?(viewModel)
        }.frame(alignment: .trailing)
      }
    })
    
  }
  
  @ViewBuilder
  private func header() -> some View {
    VStack(alignment: .leading, spacing: 8.0, content: {
      Text(viewModel.name)
        .font(Font.system(size: 16.0, weight: .bold))
        .frame(maxWidth: .infinity, alignment: .leading)
      Text("Cuisine type: \(viewModel.cuisineType)")
        .font(Font.system(size: 14.0, weight: .light))
        .frame(maxWidth: .infinity, alignment: .leading)
    })
    .frame(maxWidth: .infinity)
    .padding(8)
  }
  
  @ViewBuilder
  private func cacheableURLImage(url: URL) -> some View {
    AsyncCachableImage(url: url)
      .frame(maxWidth: 75, maxHeight: 75)
      .clipShape(Circle())
  }
  
}
