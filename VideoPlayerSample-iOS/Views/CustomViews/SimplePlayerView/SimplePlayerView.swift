//
//  SimplePlayerView.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/15.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit
import AVFoundation

class SimplePlayerView: UIView {
    @IBOutlet private weak var playerView: UIView!
    @IBOutlet private weak var shadowView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var fullScreenButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var DurationLabel: UILabel!

    private var player: AVPlayer?
    var video: Video? = nil {
        didSet {
            guard let url = URL(string: video?.videoUrl ?? "") else {
                // TODO: dismis view controller case
                return
            }
            self.player = AVPlayer(url: url)
            self.playerView.layer.addSublayer(AVPlayerLayer(player: self.player).apply {
                $0.frame = self.bounds
            })
            self.player?.play()
        }
    }
    
    // MARK: Callbacks
    var closeCallback: (() -> Void)? = nil
    var fullscreenCallback: (() -> Void)? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib()
    }
    
    deinit {
        self.player?.pause()
    }
    
    private func loadFromNib() {
        let className = SimplePlayerView.simpleClassName()
        if let view = Bundle(for: type(of: self)).loadNibNamed(className, owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
            view.fillConstraint(to: self)
            self.initializeView()
        }
    }
    
    private func initializeView() {
        self.backgroundColor = .white
        // Play on the back
        self.sendSubviewToBack(self.playerView)
    }
    
    @IBAction private func closeButtonAction(_ sender: UIButton) {
        self.player?.pause()
        self.closeCallback?()
    }
    
    @IBAction private func fullscreenButtonAction(_ sender: UIButton) {
        self.fullscreenCallback?()
    }
    
    @IBAction private func playButtonAction(_ sender: UIButton) {
        guard let player = self.player else { return }
        if player.isPlaying {
            player.pause()
            self.playButton.backgroundColor = .red
        } else {
            player.play()
            self.playButton.backgroundColor = .white
        }
    }
}
