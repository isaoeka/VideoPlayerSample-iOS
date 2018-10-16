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
    static let itemSizeRatio: CGFloat = 16.0 / 9.0
    static func estimatedCellHeight() -> CGFloat {
        let width = UIScreen.main.bounds.size.width
        return width / VideoCell.itemSizeRatio
    }

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
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return super.preferredLayoutAttributesFitting(layoutAttributes).apply {
            let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
            let autoLayoutSize = self.contentView.systemLayoutSizeFitting(
                targetSize,
                withHorizontalFittingPriority: UILayoutPriority.required,
                verticalFittingPriority: UILayoutPriority.defaultLow
            )
            $0.frame = CGRect(origin: $0.frame.origin, size: autoLayoutSize)
        }
    }
    
}
