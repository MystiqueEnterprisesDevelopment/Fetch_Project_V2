import SwiftUI
import Kingfisher

struct AsyncCachableImage: View {
  let url: URL
  
  var body: some View {
    KFImage(url)
      .placeholder({
        Image(systemName: "hourglass.circle")
          .resizable()
      })
    .resizable()
    .scaledToFit()
    .aspectRatio(contentMode: .fit)
  }
}
