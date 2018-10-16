//
//  VideoPlayerViewController.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import AVFoundation
import UIKit

protocol VideoPlayerView: class {
    func dismissViewController()
}

enum VideoPlayerStyle {
    case standard
    case fullscreen
}

class VideoPlayerViewController: UIViewController {
    @IBOutlet weak var playerView: SimplePlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private var presenter: VideoPlayerPresenter!
    var playerStyle = VideoPlayerStyle.standard
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
    override var prefersStatusBarHidden: Bool {
        // Hide if fullscreen
        return self.playerStyle == .fullscreen
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }

    override func viewDidLayoutSubviews() {
        self.playerView.updateLayoutForOrientation()
        super.viewDidLayoutSubviews()
    }
}

extension VideoPlayerViewController {
    func createPresenter(withVideo video: Video) {
        self.presenter = VideoPlayerPresenter(view: self, video: video)
    }
    
    private func initializeView() {
        let video = self.presenter.getVideo()
        self.playerView.video = video
        self.titleLabel.text = video.title ?? ""
        self.presenterNameLabel.text = video.presenterName ?? ""
        self.descriptionLabel.text = video.description ?? ""
        
        self.playerView.closeCallback = {
            self.dismissViewController()
        }
        self.playerView.fullscreenCallback = {
            self.playerStyle = .fullscreen
            // update status bar
            UIView.animate(withDuration: 0.3) {
                self.setNeedsStatusBarAppearanceUpdate()
            }
            return self.fullscreenRect()
        }
    }
    
    private func fullscreenRect() -> CGRect {
        let screenBounds = UIScreen.main.bounds
        switch self.playerStyle {
        case .standard:
            return CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        case .fullscreen:
            return CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height)
        }
    }
}

// MARK: - VideoPlayerView
extension VideoPlayerViewController: VideoPlayerView {
    func dismissViewController() {
        self.dismiss(animated: true)
    }
}
