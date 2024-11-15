import SwiftUI
import PlayerKit

struct ContentView: View {
    // Create a PlayerItem instance with title, description, and URL
    let playerItem = PlayerItem(title: "Deadpool & Wolverine",
                                url: URL(string: "https://ftp18m.cinerama.uz/hls/converted/20241001/647c3f8b1002351900d10e6df3794b40.mp4/playlist.m3u8?token=3IfdgHsQXOILgSRdQjo5_w&expires=1729107992&ip=10.32.120.2")!,
                                posterUrl: URL(string: "https://files.itv.uz/uploads/content/poster/2024/11/12//0b92c0bc082a728505ec1b181b5e6179-q-700x1002.jpeg")!,
                                castVideoUrl: URL(string: "https://st2.itv.uz/3/mp4/ftp16/2024/video/l/m/469f7c3aca4958ce6103191961bca07b.mp4?token=5aounY6sBHmi00NX5E6MbQ&e=1731696184")!
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


