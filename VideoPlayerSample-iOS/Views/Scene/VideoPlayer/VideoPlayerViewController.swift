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

class VideoPlayerViewController: UIViewController {
    @IBOutlet weak var playerView: SimplePlayerView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private var presenter: VideoPlayerPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .landscape]
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // Support only iphone
        if size.width > size.height {
            print ("to Landscape")
        } else {
            print ("to Portrait")
        }
    }
}

extension VideoPlayerViewController {
    func createPresenter(withVideo video: Video) {
        self.presenter = VideoPlayerPresenter(view: self, video: video)
    }
    
    private func initializeView() {
        let video = self.presenter.getVideo()
        self.playerView.video = video
        self.playerView.closeCallback = {
            self.dismissViewController()
        }
        self.titleLabel.text = video.title ?? ""
        self.presenterNameLabel.text = video.presenterName ?? ""
        self.descriptionLabel.text = video.description ?? ""
    }
}

// MARK: - VideoPlayerView
extension VideoPlayerViewController: VideoPlayerView {
    func dismissViewController() {
        self.dismiss(animated: true)
    }
}
