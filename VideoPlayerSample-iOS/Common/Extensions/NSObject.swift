//
//  NSObject.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import Foundation

extension NSObject {
    static func simpleClassName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
