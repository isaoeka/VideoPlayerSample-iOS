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
    @IBOutlet private weak var currentTimeLabel: TimeLabel!
    @IBOutlet private weak var durationLabel: TimeLabel!
    @IBOutlet private weak var seekProgressSlider: UISlider! {
        didSet {
            seekProgressSlider.value = 0.0
            self.seekProgressSlider.minimumValue = 0.0
            self.seekProgressSlider.maximumValue = 1.0
        }
    }
    
    private var player: AVPlayer?
    private var interval: Double {
        return Double(0.5 * self.seekProgressSlider.maximumValue) / Double(self.seekProgressSlider.bounds.maxX)
    }

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
            self.syncSeekSlider()
            self.durationLabel.msec = video?.videoDuration ?? 0
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
        // TODO: remove time ovserver
    }
    
    private func loadFromNib() {
        let className = SimplePlayerView.simpleClassName()
        if let view = Bundle(for: type(of: self)).loadNibNamed(className, owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
            view.fillConstraint(to: self)
        }
    }
    
    private func syncSeekSlider() {
        let time: CMTime = CMTimeMakeWithSeconds(self.interval, preferredTimescale: Int32(NSEC_PER_SEC))
        // TODO: check queue!!
        self.player?.addPeriodicTimeObserver(forInterval: time, queue: nil, using: { [weak self] time in
            self?.updateSeekProgressSlider(time)
        })
    }
    
    private func updateSeekProgressSlider(_ time: CMTime) {
        guard let player = self.player,
            let duration = player.currentItem?.duration.seconds else { return }
        
        self.seekProgressSlider.value = Float(time.seconds / duration)
        self.currentTimeLabel.msec = Int(time.seconds)
    }
    
    // MARK: - IBActions
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

    @IBAction private func seekProgressChanged(_ sender: UISlider) {
        guard let player = self.player,
            let duration = player.currentItem?.duration.seconds else { return }

        let seconds = Double(sender.value) * duration
        let targetTime: CMTime = CMTime(seconds: seconds, preferredTimescale: Int32(NSEC_PER_SEC))
        player.seek(to: targetTime, toleranceBefore: CMTime.zero, toleranceAfter: CMTime.zero)
        
        // Case where playback has ended
        if !player.isPlaying {
            player.play()
        }
    }
    
}
