//
//  VideoCell.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCell: UICollectionViewCell {
    static let cellHeight: CGFloat = 200.0
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var videoDurationLabel: TimeLabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var presenterNameLabel: UILabel!

    var video: Video? {
        didSet{
            guard let video = video else { return }
            if let url = URL(string: video.thumbnailUrl ?? "") {
                self.thumbnailImageView.kf.setImage(with: url)
            }
            self.videoDurationLabel.msec = video.videoDuration ?? 0
            self.titleLabel.text = video.title ?? ""
            self.descriptionLabel.text = video.description ?? ""
            self.presenterNameLabel.text = video.presenterName ?? "'"
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.initializeView()
    }
    
    private func initializeView() {
        self.backgroundColor = .white
        
    }
}
