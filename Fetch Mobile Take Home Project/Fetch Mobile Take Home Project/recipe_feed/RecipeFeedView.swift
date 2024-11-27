import SwiftUI

struct RecipeFeedView: View {
  @StateObject var viewModel: RecipeFeedViewModel
  
  var body: some View {
    mainContent()
      .overlay {
        if viewModel.isLoading {
          bufferingView()
            .edgesIgnoringSafeArea(.all)
            .animation(Animation.easeInOut(duration: 0.25), value: viewModel.isLoading)
        }
      }
  }
  
  @ViewBuilder
  func bufferingView() -> some View {
    VStack(alignment: .center, spacing: 16.0, content: {
      ProgressView()
      Text("Loading...")
    })
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 8)
        .background(Color.white)
        .foregroundStyle(.white)
        .shadow(radius: 5.0)
    )
  }
  
  @ViewBuilder
  func mainContent() -> some View {
    if viewModel.hasRecipes {
      recipeList()
    } else {
      emptyStateView()
    }
  }
  
  @ViewBuilder
  func recipeList() -> some View {
    List {
      ForEach(viewModel.recipes) { recipe_i in
        RecipeItemView(viewModel: recipe_i, seeMoreAction: { vm in
          viewModel.showRecipeDetail(forRecipe: vm)
        })
          .onTapGesture {
            viewModel.showRecipeDetail(forRecipe: recipe_i)
          }
      }
    }
    .refreshable {
      viewModel.reloadRecipes()
    }
  }
  
  @ViewBuilder
  func emptyStateView() -> some View {
    ErrorStateView(image: Image(systemName: "carrot.fill"),
                   errorTitle: "Uh oh, there are no recipes available",
                   errorSubtitle: "We might be having some troubles on our end. Please try again in a few seconds. If the problem persists, please reach out to our support team.",
                   ctaTitle: "Try again") {
      viewModel.reloadRecipes()
    }
  }
}


