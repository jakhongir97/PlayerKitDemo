import SwiftUI
import PlayerKit

struct ContentView: View {
    // Use your real HLS URL
    let videoURL = URL(string: "https://st2.itv.uz/2/hls/map/ftp15/2023/vod/k/l/0c5b99cc49a587aed38d2a8a66c131bd/master.m3u8?token=33oYxiowMGArU2fMBtQNzg&e=1728572326&traffic=0&uid=1060697&device=IPADOS&ip=10.32.120.2&mode=mapped")!

    @ObservedObject var playerManager = PlayerManager.shared
    @State private var selectedPlayerType: PlayerType = .vlcPlayer  // Default to VLC Player

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // List to select player type (VLCPlayer or AVPlayer)
            List {
                Section(header: Text("Select Player")) {
                    ForEach([PlayerType.vlcPlayer, PlayerType.avPlayer], id: \.self) { playerType in
                        Button(action: {
                            selectPlayer(type: playerType)
                        }) {
                            HStack {
                                Text(playerType.title)  // Use the title property instead of rawValue
                                Spacer()
                                if selectedPlayerType == playerType {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .frame(height: 150)

            // Use PlayerView to render the appropriate player
            PlayerView()
                .frame(height: 300)  // Set fixed height for the video view
                .onAppear {
                    playerManager.load(url: videoURL)  // Load and refresh tracks
                }

            Spacer()
        }
        .padding()
        .onAppear {
            playerManager.setPlayer(type: selectedPlayerType)  // Set the default player type
            playerManager.load(url: videoURL)                  // Load the video and auto-fetch tracks
        }
    }

    // Function to handle player type selection
    private func selectPlayer(type: PlayerType) {
        selectedPlayerType = type
        playerManager.setPlayer(type: type)
        playerManager.load(url: videoURL)
    }
}

