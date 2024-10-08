import SwiftUI
import PlayerKit

struct ContentView: View {
    let videoURL = URL(string: "https://st2.itv.uz/2/hls/map/ftp15/2023/vod/k/l/0c5b99cc49a587aed38d2a8a66c131bd/master.m3u8?token=CTY6HMiZZcNO21ZjvGaUHA&e=1728402684&traffic=0&uid=1060697&device=IOS&ip=10.32.120.2&mode=mapped")!

    @StateObject var playerManager = PlayerManager()
    @State private var selectedPlayerType: PlayerType = .vlcPlayer  // Default to VLC Player

    var body: some View {
        VStack {
            // Picker to select player type (VLCPlayer or AVPlayer)
            Picker("Select Player", selection: $selectedPlayerType) {
                Text("VLC Player").tag(PlayerType.vlcPlayer)
                Text("AVPlayer").tag(PlayerType.avPlayer)
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: selectedPlayerType) { newValue in
                playerManager.setPlayer(type: newValue)
                playerManager.load(url: videoURL)  // Load the video with the newly selected player
                playerManager.play()               // Play the video
            }

            // Conditionally render the appropriate player view based on the selected player type
            if selectedPlayerType == .vlcPlayer {
                if let currentPlayer = playerManager.currentPlayer as? VLCPlayerWrapper {
                    VLCPlayerViewRepresentable(player: currentPlayer.player)
                        .frame(height: 300)  // Set fixed height for the video view
                        .onAppear {
                            playerManager.load(url: videoURL)  // Load and play video when the view appears
                            playerManager.play()
                        }
                }
            } else if selectedPlayerType == .avPlayer {
                if let currentPlayer = playerManager.currentPlayer as? AVPlayerWrapper, let player = currentPlayer.player {
                    AVPlayerViewRepresentable(player: player)
                        .frame(height: 300)  // Set fixed height for the video view
                        .onAppear {
                            playerManager.load(url: videoURL)  // Load and play video when the view appears
                            playerManager.play()
                        }
                }
            }

            // Playback controls (Play/Pause button)
            HStack {
                Button(action: {
                    if playerManager.isPlaying {
                        playerManager.pause()  // Pause if currently playing
                    } else {
                        playerManager.play()   // Play if currently paused
                    }
                }) {
                    Text(playerManager.isPlaying ? "Pause" : "Play")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            // List of available audio tracks
            List(playerManager.availableAudioTracks.indices, id: \.self) { index in
                Button(action: {
                    playerManager.selectAudioTrack(index: index)  // Select audio track based on index
                }) {
                    HStack {
                        Text(playerManager.availableAudioTracks[index])
                        Spacer()
                        // Add a checkmark next to the currently selected audio track
                        if playerManager.selectedAudioTrackIndex == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }

            // List of available subtitle tracks
            List(playerManager.availableSubtitles.indices, id: \.self) { index in
                Button(action: {
                    playerManager.selectSubtitle(index: index)  // Select subtitle based on index
                }) {
                    HStack {
                        Text(playerManager.availableSubtitles[index])
                        Spacer()
                        // Add a checkmark next to the currently selected subtitle track
                        if playerManager.selectedSubtitleTrackIndex == index {
                            Image(systemName: "checkmark")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .onAppear {
            playerManager.setPlayer(type: selectedPlayerType)  // Set the default player type when the view appears
            playerManager.load(url: videoURL)                  // Load the video when the view appears
            playerManager.play()                               // Auto-play the video
        }
    }
}

