//
//  Video.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import ObjectMapper

class Video: Mappable {
    var title: String?
    var presenterName: String?
    var description: String?
    var thumbnailUrl: String?
    var videoUrl: String?
    var videoDuration: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.title <- map["title"]
        self.presenterName <- map["presenter_name"]
        self.description <- map["description"]
        self.thumbnailUrl <- map["thumbnail_url"]
        self.videoUrl <- map["video_url"]
        self.videoDuration <- map["video_duration"]
    }
}
