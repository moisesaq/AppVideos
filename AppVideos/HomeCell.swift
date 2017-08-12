//
//  FeedCell.swift
//  AppVideos
//
//  Created by Moises on 8/11/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class HomeCell: BaseCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    var videos: [Video]? //= Video.testVideosDragonBall()
    override func setUpView() {
        super.setUpView()
        fetchVideos()
        
        addSubview(collectionView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        registerVideoCell()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    func fetchVideos(){
        ApiService.sharedInstance.fetchHomeVideos(completion: { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        })
    }
    
    private func registerVideoCell(){
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
     

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
       cell.video = videos?[indexPath.item]
       return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       let height = (frame.width - 16 - 16) * 9 / 16 //It is for resolution 16:9
       return CGSize(width: frame.width, height: height + 16 + 80) //80 after was 68, come from Vertical constraints (VideoCell)
    }
}
