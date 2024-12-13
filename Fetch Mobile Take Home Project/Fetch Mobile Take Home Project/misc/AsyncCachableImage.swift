import SwiftUI

final class ImageCache {
  static let shared = ImageCache()
  
  private var cache: [URL: Image] = [:]
  
  func cacheImage(url: URL, image: Image) -> Image {
    cache[url] = image
    return image
  }
  
  func image(forURL url: URL) -> Image? {
    return cache[url]
  }
}

struct AsyncCachableImage: View {
  let url: URL
  
  private let imageCache = ImageCache.shared
  
  var body: some View {
    main()
  }
  
  @ViewBuilder
  private func main() -> some View {
    if let cachedImage =  imageCache.image(forURL: url) {
      cachedImage
        .resizable()
        .scaledToFit()
        .aspectRatio(contentMode: .fit)
    } else {
      AsyncImage(url: url) { image in
        imageCache.cacheImage(url: url, image: image)
          .resizable()
          .scaledToFit()
          .aspectRatio(contentMode: .fit)
      } placeholder: {
        Image(systemName: "hourglass.circle")
          .resizable()
      }
    }
  }
}
