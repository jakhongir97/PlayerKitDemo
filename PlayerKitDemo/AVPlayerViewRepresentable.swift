import SwiftUI
import AVFoundation

struct AVPlayerViewRepresentable: UIViewRepresentable {
    var player: AVPlayer

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspect  // Ensures the video is scaled properly
        playerLayer.frame = view.bounds
        view.layer.addSublayer(playerLayer)

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // Make sure the playerLayer is resized to fit the new bounds of the view
        if let playerLayer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            playerLayer.frame = uiView.bounds  // Update the player layer's frame
        }
    }

    static func dismantleUIView(_ uiView: UIView, coordinator: ()) {
        // Cleanup code if needed
        if let playerLayer = uiView.layer.sublayers?.first as? AVPlayerLayer {
            playerLayer.player = nil  // Disconnect the player when view is removed
        }
    }
}

