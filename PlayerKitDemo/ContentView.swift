import SwiftUI
import PlayerKit

struct ContentView: View {
    // Create a PlayerItem instance with title, description, and URL
    let playerItem = PlayerItem(title: "Deadpool & Wolverine",
                                url: URL(string: "https://ftp18m.cinerama.uz/hls/converted/20241001/647c3f8b1002351900d10e6df3794b40.mp4/playlist.m3u8?token=3IfdgHsQXOILgSRdQjo5_w&expires=1729107992&ip=10.32.120.2")!,
                                posterUrl: URL(string: "https://files.itv.uz/uploads/content/poster/2024/11/12//0b92c0bc082a728505ec1b181b5e6179-q-700x1002.jpeg")!,
                                castVideoUrl: URL(string: "https://st2.itv.uz/3/mp4/ftp16/2024/video/l/m/469f7c3aca4958ce6103191961bca07b.mp4?token=5aounY6sBHmi00NX5E6MbQ&e=1731696184")!
    )
    
    let playerItems = [
                        PlayerItem(title: "Movie 1",
                                   description: "Episode 1",
                                   url: URL(string: "https://ftp18m.cinerama.uz/hls/converted/20241001/647c3f8b1002351900d10e6df3794b40.mp4/playlist.m3u8")!,
                                   posterUrl: URL(string: "https://files.itv.uz/uploads/content/poster/2024/11/12//0b92c0bc082a728505ec1b181b5e6179-q-700x1002.jpeg")!,
                                   castVideoUrl: URL(string: "https://st2.itv.uz/3/mp4/ftp16/2024/video/l/m/469f7c3aca4958ce6103191961bca07b.mp4")!,
                                   episodeIndex: 0),
                        PlayerItem(title: "Movie 2",
                                   description: "Episode 2",
                                   url: URL(string: "https://storage4.itv.uz/2/hls/ftp15/2023/video/k/l/cbb6cb0e90bd444df3caf3f57fdbe82c.mp4/master.m3u8")!,
                                   posterUrl: nil,
                                   castVideoUrl: nil,
                                   episodeIndex: 1),
                        PlayerItem(title: "Movie 3",
                                   description: "Episode 3",
                                   url: URL(string: "https://storage4.itv.uz/2/hls/ftp15/2023/video/k/l/cbb6cb0e90bd444df3caf3f57fdbe82c.mp4/master.m3u8")!,
                                   posterUrl: nil,
                                   castVideoUrl: nil,
                                   episodeIndex: 2)
                    ]
    
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


