//
//  UIViewController.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

extension UIViewController {
    static func storyBoradName() -> String {
        return self.simpleClassName().replacingOccurrences(of: "ViewController", with: "")
    }
}
