//
//  VideoListViewController.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/13.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        VideoAPI.getList { videoList in
            dump(videoList)
        }
    }

}
