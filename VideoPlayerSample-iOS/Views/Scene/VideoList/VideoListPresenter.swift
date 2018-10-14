//
//  VideoListPresenter.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

final class VideoListPresenter {
    typealias View = VideoListView & UIViewController
    
    private weak var view: View?
    private var videoList: [Video] = []
    
    var numberOfVideo: Int {
        return self.videoList.count
    }
    
    init(view: View) {
        self.view = view
    }

    func video(at index: Int) -> Video? {
        guard index < self.videoList.count else { return nil }
        return self.videoList[index]
    }
    
    func getVideoList() {
        VideoAPI.getList { result in
            defer {
                self.view?.reloadData()
            }
            self.videoList = result
        }
    }
}
