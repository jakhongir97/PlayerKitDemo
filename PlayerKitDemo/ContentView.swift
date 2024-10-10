import SwiftUI
import PlayerKit

struct ContentView: View {
    // Use your real HLS URL
    let videoURL = URL(string: "https://st2.itv.uz/2/hls/map/ftp15/2023/vod/k/l/0c5b99cc49a587aed38d2a8a66c131bd/master.m3u8?token=33oYxiowMGArU2fMBtQNzg&e=1728572326&traffic=0&uid=1060697&device=IPADOS&ip=10.32.120.2&mode=mapped")!

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

