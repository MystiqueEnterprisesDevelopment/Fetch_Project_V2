import SwiftUI

struct ErrorStateView: View {
  var image: Image?
  var errorTitle: String
  var errorSubtitle: String?
  var ctaTitle: String
  var action: VoidCompletion?
  
  var body: some View {
    VStack(alignment: .center, spacing: 16.0, content: {
      if let image {
        image
          .resizable()
          .padding()
          .aspectRatio(contentMode: .fit)
      }
      Spacer()
      Text(errorTitle)
        .font(Font.system(size: 18.0, weight: .bold))
      
      if let errorSubtitle {
        Text(errorSubtitle)
          .font(Font.system(size: 14.0, weight: .regular))
      }
      
      Spacer()
      PrimaryCTA(title: ctaTitle) {
        action?()
      }
    })
    .padding()
  }
  
  
}
