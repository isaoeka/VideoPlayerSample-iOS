//
//  SimplePlayerView.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/15.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit
import AVFoundation
import FontAwesome

class SimplePlayerView: UIView {
    @IBOutlet private weak var playerTapGesterRecognizer: UITapGestureRecognizer!
    @IBOutlet private weak var playerView: AVPlayerView!
    @IBOutlet private weak var controlView: UIView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var fullScreenButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    @IBOutlet private weak var currentTimeLabel: TimeLabel!
    @IBOutlet private weak var durationLabel: TimeLabel!
    @IBOutlet private weak var seekProgressSlider: UISlider!

    private var interval: Double {
        return Double(0.5 * self.seekProgressSlider.maximumValue) / Double(self.seekProgressSlider.bounds.maxX)
    }
    var video: Video? = nil {
        didSet {
            guard let url = URL(string: video?.videoUrl ?? "") else { return }
            self.playerView.setPlayerLayer(AVPlayerLayer(player: AVPlayer(url: url)).apply {
                $0.frame = self.bounds
            })
            self.playerView.player?.play()
            self.syncSeekSlider()
            self.durationLabel.msec = video?.videoDuration ?? 0
        }
    }
    
    // MARK: Callbacks
    var closeCallback: (() -> Void)? = nil
    var fullscreenCallback: (() -> Void)? = nil // TODO: rename to expand ~

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.loadFromNib()
    }
    
    deinit {
        self.playerView.player?.pause()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension SimplePlayerView {
    private func loadFromNib() {
        let className = SimplePlayerView.simpleClassName()
        if let view = Bundle(for: type(of: self)).loadNibNamed(className, owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
            view.fillConstraint(to: self)
            self.setupViews()
        }
    }
    
    private func setupViews() {
        // views...
        self.playerTapGesterRecognizer.view?.backgroundColor = .darkGray
        self.playerView.backgroundColor = .darkGray

        // buttons...
        let buttons: [UIButton: FontAwesome] = [
            self.closeButton: .chevronDown,
            self.fullScreenButton: .expand,
            self.playButton: .pause,
            ]
        buttons.forEach { (button, name) in
            let image = self.fontImage(name: name, size: button.frame.size)
            button.tintColor = .baseWhite
            button.setImage(image, for: .normal)
            button.setTitle("", for: .normal)
        }

        // seekbar...
        self.seekProgressSlider.lets { slider in
            slider.value = 0.0
            slider.minimumValue = 0.0
            slider.maximumValue = 1.0
            let thumbnaiSize = CGSize(width: 35, height: 35)
            slider.setThumbImage(self.fontImage(name: .pencilAlt, size: thumbnaiSize, color: .white), for: .normal)
            slider.setThumbImage(self.fontImage(name: .pencilAlt, size: thumbnaiSize, color: .baseGray), for: .highlighted)
            slider.minimumTrackTintColor = .baseBlue
            slider.maximumTrackTintColor = .baseWhite
        }
    }
    
    func updateLayoutForViewState() {
        DispatchQueue.main.async {
            // Update layers layout
            self.playerView.playerLayer?.frame = self.playerView.bounds
            if UIDevice.current.orientation.isLandscape {
                self.fullScreenButton.isEnabled = false
            } else {
                self.fullScreenButton.isEnabled = true
            }
        }
    }
    
    private func syncSeekSlider() {
        let time: CMTime = CMTimeMakeWithSeconds(self.interval, preferredTimescale: Int32(NSEC_PER_SEC))
        self.playerView.player?.addPeriodicTimeObserver(forInterval: time, queue: nil, using: { [weak self] time in
            self?.updateSeekProgressSlider(time)
        })
    }
    
    private func updateSeekProgressSlider(_ time: CMTime) {
        guard let player = self.playerView.player,
            let duration = player.currentItem?.duration.seconds else { return }
        self.seekProgressSlider.value = Float(time.seconds / duration)
        self.currentTimeLabel.sec = Int(time.seconds)
    }
    
    private func fontImage(name: FontAwesome, size: CGSize, color: UIColor = .black) -> UIImage {
        return UIImage.fontAwesomeIcon(name: name, style: .solid, textColor: color, size: size)
    }
}

// MARK: - IBActions
extension SimplePlayerView {
    @IBAction func playerViewTapAction(_ sender: UITapGestureRecognizer) {
        if self.controlView.isHidden {
            // show control view
            UIView.animate(withDuration: 0.3, animations: {
                self.controlView.alpha = 1.0
            }) { isComplet in
                guard isComplet else { return }
                self.controlView.isHidden = false
            }
        } else {
            // hide control view
            UIView.animate(withDuration: 0.3, animations: {
                self.controlView.alpha = 0
            }) { isComplet in
                guard isComplet else { return }
                self.controlView.isHidden = true
            }
        }
    }
    
    @IBAction private func closeButtonAction(_ sender: UIButton) {
        self.playerView.player?.pause()
        self.closeCallback?()
    }
    
    @IBAction private func fullscreenButtonAction(_ sender: UIButton) {
        self.fullscreenCallback?()
        self.updateLayoutForViewState()
    }
    
    @IBAction private func playButtonAction(_ sender: UIButton) {
        guard let player = self.playerView.player else { return }
        if player.isPlaying {
            let image = self.fontImage(name: .play, size: self.playButton.frame.size)
            self.playButton.setImage(image, for: .normal)
            player.pause()
        } else {
            let image = self.fontImage(name: .pause, size: self.playButton.frame.size)
            self.playButton.setImage(image, for: .normal)
            player.play()
        }
    }

    @IBAction private func seekProgressChanged(_ sender: UISlider) {
        guard let player = self.playerView.player,
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
