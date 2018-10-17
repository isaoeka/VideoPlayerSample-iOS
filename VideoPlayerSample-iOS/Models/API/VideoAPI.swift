//
//  VideoAPI.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

struct VideoAPI {
    static func getList(completion: @escaping ([Video]) -> Void) {
        guard !AppConst.ApiUrl.videoList.rawValue.isEmpty else {
            assertionFailure("Please specify a url")
            return
        }
        Alamofire.request(AppConst.ApiUrl.videoList.rawValue).responseArray { (response: DataResponse<[Video]>) in
            let videoList = response.result.value ?? []
            completion(videoList)
        }
    }
}
