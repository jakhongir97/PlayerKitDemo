import SwiftUI
import PlayerKit

struct ContentView: View {
    // Use your real HLS URL
    let videoURL = URL(string: "https://st2.itv.uz/2/hls/map/ftp15/2023/vod/k/l/0c5b99cc49a587aed38d2a8a66c131bd/master.m3u8?token=CTY6HMiZZcNO21ZjvGaUHA&e=1728402684&traffic=0&uid=1060697&device=IOS&ip=10.32.120.2&mode=mapped")!

    @StateObject var playerManager = PlayerManager()
    @State private var selectedPlayerType: PlayerType = .vlcPlayer  // Default to VLC Player

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // List to select player type (VLCPlayer or AVPlayer) with section header
            List {
                Section(header: Text("Select Player")) {
                    // VLC Player Option
                    Button(action: {
                        selectPlayer(type: .vlcPlayer)
                    }) {
                        HStack {
                            Text("VLC Player")
                            Spacer()
                            if selectedPlayerType == .vlcPlayer {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }

                    // AVPlayer Option
                    Button(action: {
                        selectPlayer(type: .avPlayer)
                    }) {
                        HStack {
                            Text("AVPlayer")
                            Spacer()
                            if selectedPlayerType == .avPlayer {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .frame(height: 150)  // Adjust the height of the list

            // Conditionally render the appropriate player view based on the selected player type
            ZStack {
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
                    } else {
                        // Fallback for when AVPlayer isn't initialized
                        Text("AVPlayer not initialized")
                            .frame(height: 300)
                            .foregroundColor(.red)
                    }
                }

                // Play/Pause button in the center of the player
                Button(action: {
                    if playerManager.isPlaying {
                        playerManager.pause()  // Pause if currently playing
                    } else {
                        playerManager.play()   // Play if currently paused
                    }
                }) {
                    Image(systemName: playerManager.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)  // Adjust the size of the play/pause button
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.7))
                        .clipShape(Circle())
                }
                .buttonStyle(PlainButtonStyle())
            }

            // List of available audio tracks with section header
            if !playerManager.availableAudioTracks.isEmpty {
                List {
                    Section(header: Text("Audio Tracks")) {
                        ForEach(playerManager.availableAudioTracks.indices, id: \.self) { index in
                            Button(action: {
                                playerManager.selectAudioTrack(index: index)  // Select audio track based on index
                            }) {
                                HStack {
                                    Text(playerManager.availableAudioTracks[safe: index] ?? "Unknown")
                                    Spacer()
                                    // Add a checkmark next to the currently selected audio track
                                    if playerManager.selectedAudioTrackIndex == index {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                        }
                    }
                }
            }

            // List of available subtitle tracks with section header
            if !playerManager.availableSubtitles.isEmpty {
                List {
                    Section(header: Text("Subtitle Tracks")) {
                        ForEach(playerManager.availableSubtitles.indices, id: \.self) { index in
                            Button(action: {
                                playerManager.selectSubtitle(index: index)  // Select subtitle based on index
                            }) {
                                HStack {
                                    Text(playerManager.availableSubtitles[safe: index] ?? "Unknown")
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
                }
            }
            Spacer()
        }
        .padding()
        .onAppear {
            playerManager.setPlayer(type: selectedPlayerType)  // Set the default player type when the view appears
            playerManager.load(url: videoURL)                  // Load the video when the view appears
            playerManager.play()                               // Auto-play the video
        }
    }

    // Function to handle player type selection and reset tracks
    private func selectPlayer(type: PlayerType) {
        selectedPlayerType = type
        playerManager.selectedAudioTrackIndex = nil
        playerManager.selectedSubtitleTrackIndex = nil
        playerManager.setPlayer(type: type)
        playerManager.load(url: videoURL)
        playerManager.play()
    }
}

