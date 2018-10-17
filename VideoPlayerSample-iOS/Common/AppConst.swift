//
//  AppConst.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

struct AppConst {
    enum ApiUrl: String {
        /**
         Please enter URL of `Video` format in ApiUrl.videoList :)
         ```
         [
            {"title": "xxx", "presenter_name": "xxx", "description": "xxx", "thumbnail_url": "x", "video_url": "xxx", "video_duration": 97000},
            {"title": "xxx", "presenter_name": "xxx", "description": "xxx", "thumbnail_url": "x", "video_url": "xxx", "video_duration": 97000},
            ...
         ]
         ```
         */
        case videoList = ""
    }
}
