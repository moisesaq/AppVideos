//
//  ViewController.swift
//  AppVideos
//
//  Created by Moises on 7/31/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos: [Video]? //= Video.testVideosDragonBall()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false //Remove opacity from navigation bar

        customizeNavigationTitleLabel()
        configCollectionView()
        registerVideoCell()
        setUpMenuBar()
        setUpNavBarButtons()
        
        Video.findVideos(){ (result: [Video]) in
            self.videos = result
            self.collectionView?.reloadData()
        }
    }
    
    fileprivate func customizeNavigationTitleLabel(){
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    private func configCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) //Add a box like space on the top
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0) //Add a box like space on the top to scroll indicator
    }
    
    private func registerVideoCell(){
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setUpMenuBar(){
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
    }
    
    func setUpNavBarButtons(){
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        searchBarButtonItem.width = 28
        
        let moreImage = UIImage(named: "more")?.withRenderingMode(.alwaysOriginal)
        let moreBarButtonItem = UIBarButtonItem(image: moreImage, style: .plain, target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem, searchBarButtonItem]
    }
    
    func handleSearch(){
        print("Seach")
    }
    
    func handleMore(){
        Video.findVideos(){ (result: [Video]) in
            print(result)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16 //It is for resolution 16:9
        return CGSize(width: view.frame.width, height: height + 16 + 80) //80 after was 68, come from Vertical constraints (VideoCell)
    }
}

