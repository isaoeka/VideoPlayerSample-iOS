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
    @IBOutlet weak var simplePlayerView: SimplePlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var simplePlayerViewRatio: NSLayoutConstraint!
    @IBOutlet var simplePlayerViewBottomAnker: NSLayoutConstraint!
    
    private var presenter: VideoPlayerPresenter!
    private var playerStyle = VideoPlayerStyle.standard
    private var playerOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
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
        self.simplePlayerView.updateLayoutForOrientation()
        super.viewDidLayoutSubviews()
    }
}

extension VideoPlayerViewController {
    func createPresenter(withVideo video: Video) {
        self.presenter = VideoPlayerPresenter(view: self, video: video)
    }
    
    private func initializeView() {
        let video = self.presenter.getVideo()
        self.simplePlayerView.video = video
        self.titleLabel.text = video.title ?? ""
        self.presenterNameLabel.text = video.presenterName ?? ""
        self.descriptionLabel.text = video.description ?? ""
        
        // cakbacks..
        self.simplePlayerView.closeCallback = {
            self.dismissViewController()
        }
        self.simplePlayerView.fullscreenCallback = {
            self.playerStyle = self.simplePlayerViewRatio.isActive
                            ? .fullscreen : .standard
            self.setNeedsStatusBarAppearanceUpdate()
            self.changePlayerStyle()
        }
    }
    
    private func changePlayerStyle() {
        // Attention in order to change constraint.
        switch self.playerStyle {
        case .standard:
            self.simplePlayerViewBottomAnker.isActive = false
            self.simplePlayerViewRatio.isActive = true
        case .fullscreen:
            self.simplePlayerViewRatio.isActive = false
            self.simplePlayerViewBottomAnker.isActive = true
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
