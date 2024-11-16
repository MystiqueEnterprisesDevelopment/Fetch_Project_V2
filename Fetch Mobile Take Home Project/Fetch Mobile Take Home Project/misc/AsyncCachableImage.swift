import SwiftUI
import Kingfisher

struct AsyncCachableImage: View {
  let url: URL
  
  var body: some View {
    KFImage(url)
    .resizable()
    .scaledToFit()
    .aspectRatio(contentMode: .fit)
  }
}
