//
//  Applicable.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/14.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import Foundation

protocol Applicable {}
extension Applicable {
    @discardableResult
    func apply(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Applicable {}
