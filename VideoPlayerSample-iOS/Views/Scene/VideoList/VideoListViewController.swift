//
//  VideoListViewController.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/13.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

class VideoListViewController: UIViewController {
    private lazy var presenter = VideoListPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.presenter.getVideoList()
    }

}
