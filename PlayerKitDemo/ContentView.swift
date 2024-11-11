import SwiftUI
import PlayerKit

struct ContentView: View {
    // Use your real HLS URL
    let videoURL = URL(string: "https://st1.itv.uz/2/hls/map/ftp15/2023/vod/k/l/0c5b99cc49a587aed38d2a8a66c131bd/master.m3u8?token=wVoiVmnndOUfmU-RlaYkng&e=1731341623&traffic=0&uid=3411046&device=IPADOS&ip=10.32.120.2&mode=mapped")!

    var body: some View {
        PlayerView()
            .onAppear {
                PlayerManager.shared.load(url: videoURL)
            }
    }
}

