import SwiftUI
import PlayerKit

struct ContentView: View {
    // Create a PlayerItem instance with title, description, and URL
    let playerItem = PlayerItem(title: "Deadpool & Wolverine",
                                url: URL(string: "https://ftp18m.cinerama.uz/hls/converted/20241001/647c3f8b1002351900d10e6df3794b40.mp4/playlist.m3u8?token=3IfdgHsQXOILgSRdQjo5_w&expires=1729107992&ip=10.32.120.2")!
    )
    
    @State private var isPlayerPresented = false

    var body: some View {
        VStack {
            Button("Play") {
                isPlayerPresented = true
            }
            .padding()
            .font(.title)
        }
        .fullScreenCover(isPresented: $isPlayerPresented) {
            PlayerView(playerItem: playerItem)
        }
    }
}


