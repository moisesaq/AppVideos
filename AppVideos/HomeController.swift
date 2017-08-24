//
//  ViewController.swift
//  AppVideos
//
//  Created by Moises on 7/31/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let titles = ["Home", "Trending", "Subscriptions", "Account"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationTitleLabel()
        configCollectionView()
        regiterCells()
        setUpMenuBar()
        setUpNavBarButtons()
    }
    
    //THIS CODE ALIGN TITLE TO RIGHT AND CUSTOMIZE IT
    fileprivate func customizeNavigationTitleLabel(){
        navigationItem.title = "Home"
        navigationController?.navigationBar.isTranslucent = false //Remove opacity from navigation bar
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
    }
    
    private func configCollectionView(){
        
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0) //Add a box like space on the top
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0) //Add a box like space on the top to scroll indicator
        
        collectionView?.isPagingEnabled = true
    }
    
    let homeCellId = "feedCellId"
    let trendingCellId = "trendingCellId"
    let subscriptionsCellId = "subscriptionsCellId"
    
    private func regiterCells(){
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: homeCellId)
        collectionView?.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellId)
        collectionView?.register(SubscriptionsCell.self, forCellWithReuseIdentifier: subscriptionsCellId)
    }
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    private func setUpMenuBar(){
        navigationController?.hidesBarsOnSwipe = true //Enable for hide navigation bar with scroll
        
        let redView = UIView()
        redView.backgroundColor = UIColor.redNavigationBar()
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
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
        showScrollToMenuIndex(menuIndex: 2)
    }
    
    func showScrollToMenuIndex(menuIndex: Int){
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        setTitleNavigationItem(index: menuIndex)
    }
    
    func setTitleNavigationItem(index: Int){
        if let titleLabel = navigationItem.titleView as? UILabel{
            titleLabel.text = titles[index]
        }
    }
    
    // ---------- SETTINGS -----------
    lazy var setting: SettingLauncher = {
        let setting = SettingLauncher()
        setting.homeController = self
        return setting
    }()
    
    func handleMore(){
        setting.showSetting()
    }
    
    func showControllerForSetting(setting: Setting){
        let dummySettingViewController = UIViewController()
        dummySettingViewController.view.backgroundColor = .white
        dummySettingViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    // Mark in menubar item correct
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    // NECESSARY FOR PAINT THE ITEM CORRECT INTO MENUBAR
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.move().x / view.frame.width)
        
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally) // TODO: Put this functionality to MenuBar
        setTitleNavigationItem(index: index)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier = homeCellId;
        
        if indexPath.item == 1 {
            identifier = trendingCellId
        }else if indexPath.item == 2 {
            identifier = subscriptionsCellId
        }
        
        return collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50) //-50 for navigation item
    }
    
    
}

