import SwiftUI

struct LoadingView: View {
  @ObservedObject var viewModel: LoadingViewModel
  
  var body: some View {
    mainContent()
      .onAppear(perform: {
        viewModel.startLoading()
      })
  }
  
  @ViewBuilder
  func mainContent() -> some View {
    if viewModel.isLoading {
      bufferingView()
        .frame(alignment: .center)
    }
    
    if viewModel.isErrored {
      ErrorStateView(image: Image(systemName: "exclamationmark.triangle.fill"),
                     errorTitle: "Uh oh, there are no recipes available",
                     errorSubtitle: "We might be having some troubles on our end. Please try again in a few seconds. If the problem persists, please reach out to our support team.",
                     ctaTitle: "Try again",
                     action: {
        viewModel.retryLoading()
      })
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
}


