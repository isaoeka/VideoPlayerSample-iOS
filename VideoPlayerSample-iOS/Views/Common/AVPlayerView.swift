//
//  AVPlayerView.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/16.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit
import AVFoundation

final class AVPlayerView: UIView {
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    var player: AVPlayer? {
        return self.playerLayer?.player
    }
    
    var playerLayer: AVPlayerLayer? {
        return self.layer.sublayers?.first { $0 is AVPlayerLayer } as? AVPlayerLayer
    }
    
    func setPlayerLayer(_ newLayer: AVPlayerLayer) {
        if let oldLayer = self.playerLayer {
            oldLayer.removeFromSuperlayer()
        }
        self.layer.addSublayer(newLayer)
    }
}
