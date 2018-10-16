//
//  IndentLabel.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/16.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

final class IndentLabel: UILabel {
    var insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.insets))
    }
}
