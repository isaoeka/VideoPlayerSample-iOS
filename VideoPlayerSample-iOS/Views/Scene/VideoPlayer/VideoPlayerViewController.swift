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
    @IBOutlet weak var titleLabel: IndentLabel!
    @IBOutlet weak var presenterNameLabel: IndentLabel!
    @IBOutlet weak var descriptionLabel: IndentLabel!
    @IBOutlet var simplePlayerViewRatio: NSLayoutConstraint!
    @IBOutlet var simplePlayerViewBottomAnker: NSLayoutConstraint!
    
    private var presenter: VideoPlayerPresenter!
    private var playerStyle: VideoPlayerStyle = .standard
    private var isLandscape: Bool { return UIDevice.current.orientation.isLandscape }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.playerStyle == .fullscreen
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
        } else {
            self.playerStyle = self.isLandscape ? .fullscreen : .standard
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.changePlayerStyle(self.playerStyle)
    }
}

extension VideoPlayerViewController {
    func createPresenter(withVideo video: Video) {
        self.presenter = VideoPlayerPresenter(view: self, video: video)
    }
    
    private func setupView() {
        self.setNeedsStatusBarAppearanceUpdate()
        
        // style setup...
        self.playerStyle = UIDevice.current.orientation.isLandscape ? .fullscreen : .standard
        self.changePlayerStyle(self.playerStyle)

        // ui setup....
        self.setupLabels()
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
    
    private func setupLabels() {
        self.titleLabel.textColor = .white
        self.titleLabel.insets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        self.titleLabel.backgroundColor = .baseBlue

        self.presenterNameLabel.textColor = .white
        self.presenterNameLabel.backgroundColor = .baseBlue
        self.presenterNameLabel.insets = UIEdgeInsets(top: 0, left: 20, bottom: 10, right: 20)
        self.presenterNameLabel.addBorderViews(bottom: true, color: .lightBlue)

        self.descriptionLabel.textColor = .darkGray
        self.descriptionLabel.insets = UIEdgeInsets(top: 12, left: 20, bottom: 10, right: 20)
    }
    
    private func changePlayerStyle(_ style: VideoPlayerStyle) {
        // constraint rework...
        switch (UIDevice.current.orientation, style) {
        case (.portrait, .standard),
             (.portrait, .fullscreen):
            
            self.switchConstraint(style)
        case (.landscapeLeft, .fullscreen),
             (.landscapeRight, .fullscreen):
            
            // from .fullscreen to .fullscreen
            if self.playerStyle == style {
                self.switchConstraint(style)
            } else {
                self.switchConstraint(style)
            }
        default:
            // does not exist
            break
        }
        
        // update player layout
        self.setNeedsStatusBarAppearanceUpdate()
        self.simplePlayerView.updateLayoutForViewState()

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
