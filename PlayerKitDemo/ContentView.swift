import SwiftUI
import PlayerKit

struct ContentView: View {
    // Use your real HLS URL
    let videoURL = URL(string: "https://ftp18m.cinerama.uz/hls/converted/20241001/647c3f8b1002351900d10e6df3794b40.mp4/playlist.m3u8?token=3IfdgHsQXOILgSRdQjo5_w&expires=1729107992&ip=10.32.120.2")!

    @ObservedObject var playerManager = PlayerManager.shared
    @State private var selectedPlayerType: PlayerType = .vlcPlayer  // Default to VLC Player

    var body: some View {
        VStack(spacing: 16) {
            // Player Type Selection List
            playerSelectionList()

            // Render the player with dynamic width and height, keeping a 16:9 aspect ratio
            GeometryReader { geometry in
                PlayerView()
                    .frame(width: geometry.size.width, height: geometry.size.width * 9 / 16)  // 16:9 aspect ratio
                    .onAppear {
                        playerManager.load(url: videoURL)  // Load and refresh tracks
                    }
            }
            .frame(maxHeight: .infinity)

            Spacer()
        }
        .padding()
        .onAppear {
            setupPlayer()
        }
    }

    // MARK: - Player Selection List
    private func playerSelectionList() -> some View {
        List {
            Section(header: Text("Select Player")) {
                ForEach([PlayerType.vlcPlayer, PlayerType.avPlayer], id: \.self) { playerType in
                    Button(action: {
                        selectPlayer(type: playerType)
                    }) {
                        HStack {
                            Text(playerType.title)
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
    }

    // MARK: - Setup Player
    private func setupPlayer() {
        playerManager.setPlayer(type: selectedPlayerType)
        playerManager.load(url: videoURL)
    }

    // MARK: - Handle Player Type Selection
    private func selectPlayer(type: PlayerType) {
        selectedPlayerType = type
        setupPlayer()  // Re-setup player with new type
    }
}

