//
//  VideoCell.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    var video: Video? {
        didSet{
            guard let video = video else { return }
            dump(video)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.backgroundColor = .gray
    }

}
