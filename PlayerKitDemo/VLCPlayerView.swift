//
//  VLCPlayerView.swift
//  PlayerKitDemo
//
//  Created by Jakhongir Nematov on 08/10/24.
//

import SwiftUI
import UIKit
import PlayerKit

struct VLCPlayerView: UIViewRepresentable {
    let videoURL: URL
    private let playerWrapper = VLCPlayerWrapper()

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        playerWrapper.playVideo(from: videoURL, on: view)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Any updates needed for the UIView can be handled here
    }

    // Play the video
    func play() {
        playerWrapper.playVideo(from: videoURL, on: playerWrapper.player.drawable as! UIView)
    }

    // Pause the video
    func pause() {
        playerWrapper.pause()
    }

    // Seek to a specific position in the video
    func seek(to time: Float) {
        playerWrapper.seek(to: time)
    }

    // Get the duration of the video
    var duration: Float {
        return playerWrapper.duration
    }

    // Get available audio tracks
    var audioTracks: [Int: String] {
        return playerWrapper.audioTracks
    }

    // Switch to a specific audio track
    func switchAudioTrack(to trackID: Int) {
        playerWrapper.switchAudioTrack(to: trackID)
    }

    // Get available subtitle tracks
    var subtitleTracks: [Int: String] {
        return playerWrapper.subtitleTracks
    }

    // Switch to a specific subtitle track
    func switchSubtitleTrack(to trackID: Int) {
        playerWrapper.switchSubtitleTrack(to: trackID)
    }
}
