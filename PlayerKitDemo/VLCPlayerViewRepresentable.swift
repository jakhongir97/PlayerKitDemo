//
//  VLCPlayerViewRepresentable.swift
//  PlayerKitDemo
//
//  Created by Jakhongir Nematov on 07/10/24.
//

import SwiftUI
import VLCKit

struct VLCPlayerViewRepresentable: UIViewRepresentable {
    var player: VLCMediaPlayer

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        player.drawable = view  // Assign the VLC drawable to the view
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        player.drawable = uiView
    }

    // Add this to handle view removal or player cleanup
    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        // Release VLC resources when the view is removed
        if let player = uiView.layer.sublayers?.first as? VLCMediaPlayer {
            player.stop()
        }
    }
}

