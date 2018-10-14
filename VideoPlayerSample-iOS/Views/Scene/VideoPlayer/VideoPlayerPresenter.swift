//
//  VideoPlayerPresenter.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//
import UIKit

final class VideoPlayerPresenter {
    typealias View = UIViewController
    
    private weak var view: View?
    private var video: Video
    
    init(view: View, video: Video) {
        self.view = view
        self.video = video
    }
    
    func getVideo() -> Video {
        return self.video
    }
}
