//
//  SettingLauncher.swift
//  AppVideos
//
//  Created by Moises on 8/8/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class SettingLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let cellId = "cellId"
    
    override init() {
        super.init()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    let blackWindow = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    func showSetting(){
        if let window = UIApplication.shared.keyWindow{
            blackWindow.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackWindow.addGestureRecognizer(
                UITapGestureRecognizer(target: self, action: #selector(dismissSettings)))
            
            blackWindow.frame = window.frame
            blackWindow.alpha = 0
            
            let height: CGFloat = CGFloat(settings.count * 50);
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            window.addSubview(blackWindow)
            window.addSubview(collectionView)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
                self.blackWindow.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    func dismissSettings(){
        handleDismiss(closure: nil)
    }
    
    var homeController: HomeController?
    
    func handleDismiss(closure: (() -> Void)?){
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.blackWindow.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        }){ (completed: Bool) in
            closure?()
        }
    }
    let settings: [Setting] = Setting.getSettingList()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? SettingCell
        let setting = settings[indexPath.item]
        cell?.setting = setting
        return cell!;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismiss(closure: {
            if setting.name != .cancel {
             self.homeController?.showControllerForSetting(setting: setting)
            }
        })
    }
    
}
