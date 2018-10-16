//
//  UIColor.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/15.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(_ red: Int, _ green: Int, _ blue: Int, _ alpha: Int = 255) {
        let rgba = [red, green, blue, alpha].map { i -> CGFloat in
            switch i {
            case let i where i < 0:
                return 0
            case let i where i > 255:
                return 1
            default:
                return CGFloat(i) / 255
            }
        }
        self.init(red: rgba[0], green: rgba[1], blue: rgba[2], alpha: rgba[3])
    }
    
    static var baseWhite: UIColor { return UIColor(245, 245, 240) }
    static var baseBlue: UIColor { return UIColor(53, 91, 165) }
    static var lightBlue: UIColor { return UIColor(66, 128, 228) }
    static var baseGray: UIColor { return UIColor(149, 190, 241) }
    static var lightGray: UIColor { return UIColor(136, 136, 136) }
}
