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
        set {
            let layer: AVPlayerLayer = self.layer as! AVPlayerLayer
            layer.player = player
        }
        get {
            let layer: AVPlayerLayer = self.layer as! AVPlayerLayer
            return layer.player
        }
    }
}
