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
    
    private var presenter: VideoPlayerPresenter!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
    }
    
    func createPresenter(withVideo video: Video) {
        self.presenter = VideoPlayerPresenter(view: self, video: video)
    }
    
    private func initializeView() {
        // TODO: Make custom player view
        self.playerView.backgroundColor = .white

        let video = self.presenter.getVideo()
        if let url = URL(string: video.videoUrl ?? "") {
            let player = AVPlayer(url: url)
        self.playerView.layer.addSublayer(AVPlayerLayer(player: player).apply {
                $0.frame = self.playerView.bounds
            })
            player.play()
        } else {
            // TODO: dismis view controller case
        }
        
        self.titleLabel.text = video.title ?? ""
        self.presenterNameLabel.text = video.presenterName ?? ""
        self.descriptionLabel.text = video.description ?? ""
    }
    
}

// MARK: - VideoPlayerView
extension VideoPlayerViewController: VideoPlayerView {
    func dismissViewController() {
        self.parent?.dismiss(animated: true)
    }
}
