//
//  TimeLabel.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/15.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

class TimeLabel: UILabel {
    var msec: Int? {
        didSet {
            self.text = self.convertToDisplayTime(msec: msec ?? 0)
        }
    }
    var sec: Int? {
        didSet {
            self.text = self.convertToDisplayTime(sec: sec ?? 0)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initFont()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initFont()
    }
    
    private func initFont() {
        self.text = "00:00"
        self.backgroundColor = UIColor(30, 30, 30, 200)
        self.layer.cornerRadius = 4.0
        self.clipsToBounds = true

        self.textColor = .white
        self.textAlignment = .center
        self.font = UIFont.systemFont(ofSize: 14.0)
    }
    
    private func convertToDisplayTime(msec: Int? = nil, sec: Int? = nil) -> String {
        let sec = sec ?? msec?.lets { Int($0 / 1000) } ?? 0
        let hours =  sec / 3600
        let minutes = sec % 3600 / 60
        let seconds = sec % 60
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, seconds)
        }
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
