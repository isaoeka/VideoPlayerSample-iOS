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
    
    func change() -> VideoPlayerStyle {
        return self == .standard ? .fullscreen : .standard
    }
}

class VideoPlayerViewController: UIViewController {
    @IBOutlet weak var simplePlayerView: SimplePlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet var simplePlayerViewRatio: NSLayoutConstraint!
    @IBOutlet var simplePlayerViewBottomAnker: NSLayoutConstraint!
    
    private var presenter: VideoPlayerPresenter!
    private var playerStyle: VideoPlayerStyle = .standard
    private var isLandscape: Bool { return UIDevice.current.orientation.isLandscape }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
    override var prefersStatusBarHidden: Bool {
        return true // allways hide
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // Support only iphone
        if size.width > size.height {
            self.playerStyle = .fullscreen
            self.changePlayerStyle(self.playerStyle)
        } else {
            self.playerStyle = self.isLandscape ? .fullscreen : .standard
            self.changePlayerStyle(self.playerStyle)
        }
    }
}

extension VideoPlayerViewController {
    func createPresenter(withVideo video: Video) {
        self.presenter = VideoPlayerPresenter(view: self, video: video)
    }
    
    private func setupView() {
        self.setNeedsStatusBarAppearanceUpdate()
        self.playerStyle = UIDevice.current.orientation.isLandscape ? .fullscreen : .standard
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
            // ~~ style change ~~
            self.changePlayerStyle(self.playerStyle.change())
        }
    }
    
    private func changePlayerStyle(_ style: VideoPlayerStyle) {
        dump((UIDevice.current.orientation.rawValue, style))
        switch (UIDevice.current.orientation, style) {
        case (.portrait, .standard):
            self.switchConstraint(style)
        case (.portrait, .fullscreen):
            self.switchConstraint(style)
        case (.landscapeLeft, .fullscreen):
            if self.playerStyle != style {
                self.switchConstraint(style)
            }
            self.simplePlayerView.updateLayoutForViewState()
        case (.landscapeRight, .fullscreen):
            if self.playerStyle != style {
                self.switchConstraint(style)
            }
            self.switchConstraint(style)
            self.simplePlayerView.updateLayoutForViewState()
        default:
            // does not exist
            break
        }
        
        // set global style
        self.playerStyle = style
    }
    
    private func switchConstraint(_ style: VideoPlayerStyle) {
        // Attention in order to change constraint.
        switch style {
        case .standard:
            self.simplePlayerViewBottomAnker.isActive = false
            self.simplePlayerViewRatio.isActive = true
        case .fullscreen:
            self.simplePlayerViewRatio.isActive = false
            self.simplePlayerViewBottomAnker.isActive = true
        }
    }
}

// MARK: - VideoPlayerView
extension VideoPlayerViewController: VideoPlayerView {
    func dismissViewController() {
        self.dismiss(animated: true)
    }
}
