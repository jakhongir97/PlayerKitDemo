import SwiftUI
import AVFoundation
import UIKit

struct AVPlayerViewRepresentable: UIViewRepresentable {
    var player: AVPlayer

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)
        
        // Update the playerLayer when the view's bounds change
        context.coordinator.playerLayer = playerLayer

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Adjust the player layer frame if the view size changes
        context.coordinator.playerLayer?.frame = uiView.bounds
    }

    // Coordinator to handle player layer updates
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var playerLayer: AVPlayerLayer?

        init(_ parent: AVPlayerViewRepresentable) {
            super.init()
        }
    }
}


