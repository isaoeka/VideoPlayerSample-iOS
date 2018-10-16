//
//  UIView.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/15.
//  Copyright © 2018 isaoeka. All rights reserved.
//


import UIKit

extension UIView {
    func fillConstraint(to view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func addBorderViews(top: Bool = false, left: Bool = false, bottom: Bool = false, right: Bool = false,
                        color: UIColor = .darkGray, width: CGFloat = 1.0) {
        let borderView = UIView().apply {
            $0.backgroundColor = color
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        if top {
            self.addSubview(borderView)
            NSLayoutConstraint.activate([
                borderView.topAnchor.constraint(equalTo: self.topAnchor),
                borderView.leftAnchor.constraint(equalTo: self.leftAnchor),
                borderView.rightAnchor.constraint(equalTo: self.rightAnchor),
                borderView.heightAnchor.constraint(equalToConstant: width),
                ])
        }
        if left {
            self.addSubview(borderView)
            NSLayoutConstraint.activate([
                borderView.leftAnchor.constraint(equalTo: self.leftAnchor),
                borderView.topAnchor.constraint(equalTo: self.topAnchor),
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                borderView.widthAnchor.constraint(equalToConstant: width),
                ])
        }
        if bottom {
            self.addSubview(borderView)
            NSLayoutConstraint.activate([
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                borderView.leftAnchor.constraint(equalTo: self.leftAnchor),
                borderView.rightAnchor.constraint(equalTo: self.rightAnchor),
                borderView.heightAnchor.constraint(equalToConstant: width),
                ])
        }
        if right {
            self.addSubview(borderView)
            NSLayoutConstraint.activate([
                borderView.rightAnchor.constraint(equalTo: self.rightAnchor),
                borderView.topAnchor.constraint(equalTo: self.topAnchor),
                borderView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                borderView.widthAnchor.constraint(equalToConstant: width),
                ])
        }
    }
}
