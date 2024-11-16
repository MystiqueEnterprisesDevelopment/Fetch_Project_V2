import SwiftUI
import AVKit

/*
 Doesnt work with just a youtube link, but should work if the url is an actual video file, or at least an mp3/mp4
 */

class VideoPlayerViewModel: ObservableObject {
  let url: URL
  let player: AVPlayer
  
  init(url: URL) {
    self.url = url
    self.player = AVPlayer(url: url)
  }
  
  func startVideo() {
    self.player.play()
  }
  
  func stopVideo() {
    self.player.pause()
  }
  
}

struct VideoPlayerView: View {
  @ObservedObject var viewModel: VideoPlayerViewModel
  
  var body: some View {
    VideoPlayer(player: viewModel.player)
      .edgesIgnoringSafeArea(.all)
      .onAppear {
        viewModel.startVideo()
      }
      .onDisappear {
        viewModel.stopVideo()
      }
      .frame(minWidth: 250, maxWidth: .infinity, minHeight: 250, maxHeight: .infinity)
  }
}
