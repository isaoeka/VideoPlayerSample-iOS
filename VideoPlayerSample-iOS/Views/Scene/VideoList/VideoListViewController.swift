//
//  VideoListViewController.swift
//  VideoPlayerSample-iOS
//
//  Created by isaoeka on 2018/10/13.
//  Copyright © 2018 isaoeka. All rights reserved.
//

import UIKit

protocol VideoListView: class {
    func reloadData()
}

class VideoListViewController: UIViewController {
    
    private lazy var presenter = VideoListPresenter(view: self)
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
        
        self.presenter.getVideoList()
    }
    
    private func initializeView() {
        let nib = UINib(nibName: VideoCell.simpleClassName(), bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: VideoCell.simpleClassName())
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout().apply {
            $0.scrollDirection = .vertical
            $0.itemSize = CGSize(width: self.collectionView.frame.width, height: 150)
        }
        self.collectionView.dataSource = self
    }
}

// MARK: - VideoListView
extension VideoListViewController: VideoListView {
    func reloadData() {
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource
extension VideoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.numberOfVideo
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCell.simpleClassName(), for: indexPath) as! VideoCell
        if let video = self.presenter.video(at: indexPath.row) {
            cell.video = video
        }
        return cell
    }
}
