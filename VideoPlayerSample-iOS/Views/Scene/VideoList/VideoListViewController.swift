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
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private lazy var presenter = VideoListPresenter(view: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initializeView()
        self.presenter.getVideoList()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}

extension VideoListViewController {
    private func initializeView() {
        let nib = UINib(nibName: VideoCell.simpleClassName(), bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: VideoCell.simpleClassName())
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout().apply {
            $0.scrollDirection = .vertical
            $0.minimumLineSpacing = 0
            // Warning comes out when estimatedItemSize becomes larger than screen size ... :<
            $0.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: VideoCell.estimatedCellHeight())
            $0.itemSize = CGSize(width: self.collectionView.frame.width, height: VideoCell.estimatedCellHeight())
        }
        self.collectionView.backgroundColor = .baseWhite
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
}

// MARK: - VideoListView
extension VideoListViewController: VideoListView {
    func reloadData() {
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension VideoListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let video = self.presenter.video(at: indexPath.row),
            let viewController = UIStoryboard(name: VideoPlayerViewController.storyBoradName(), bundle: nil).instantiateInitialViewController() as? VideoPlayerViewController else {
            return
        }
        viewController.createPresenter(withVideo: video)
        self.present(viewController, animated: true)
    }
}
