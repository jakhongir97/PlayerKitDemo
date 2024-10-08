import SwiftUI
import PlayerKit

struct ContentView: View {
    let videoURL = URL(string: "https://st2.itv.uz/2/hls/map/ftp15/2023/vod/k/l/0c5b99cc49a587aed38d2a8a66c131bd/master.m3u8?token=CTY6HMiZZcNO21ZjvGaUHA&e=1728402684&traffic=0&uid=1060697&device=IOS&ip=10.32.120.2&mode=mapped")!
    @State private var isPlaying = false
    @State private var playbackPosition: Float = 0.0
    @State private var showAudioTracks = false
    @State private var showSubtitleTracks = false

    // The VLCPlayerView wrapper for SwiftUI
    var playerView: VLCPlayerView

    init() {
        playerView = VLCPlayerView(videoURL: videoURL)
    }

    var body: some View {
        VStack {
            playerView
                .frame(height: 300)  // Set a fixed height for the video view

            HStack {
                Button(action: {
                    if isPlaying {
                        playerView.pause()
                    } else {
                        playerView.play()
                    }
                    isPlaying.toggle()
                }) {
                    Text(isPlaying ? "Pause" : "Play")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            Slider(value: $playbackPosition, in: 0.0...1.0, onEditingChanged: { editing in
                if !editing {
                    let seekTime = playbackPosition * playerView.duration
                    playerView.seek(to: seekTime)
                }
            })
            .padding()

            HStack {
                Button(action: {
                    showAudioTracks.toggle()
                }) {
                    Text("Audio Tracks")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            if showAudioTracks {
                VStack {
                    ForEach(playerView.audioTracks.keys.sorted(), id: \.self) { trackID in
                        Button(action: {
                            playerView.switchAudioTrack(to: trackID)
                            showAudioTracks = false
                        }) {
                            Text(playerView.audioTracks[trackID] ?? "Unknown")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }

            HStack {
                Button(action: {
                    showSubtitleTracks.toggle()
                }) {
                    Text("Subtitles")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            if showSubtitleTracks {
                VStack {
                    ForEach(playerView.subtitleTracks.keys.sorted(), id: \.self) { trackID in
                        Button(action: {
                            playerView.switchSubtitleTrack(to: trackID)
                            showSubtitleTracks = false
                        }) {
                            Text(playerView.subtitleTracks[trackID] ?? "Unknown")
                                .padding()
                                .background(Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                }
            }
        }
    }
}
