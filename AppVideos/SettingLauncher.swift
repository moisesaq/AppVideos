//
//  SettingLauncher.swift
//  AppVideos
//
//  Created by Moises on 8/8/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class SettingLauncher: NSObject{
    
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
            blackWindow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            blackWindow.frame = window.frame
            blackWindow.alpha = 0
            
            let height: CGFloat = 300;
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            window.addSubview(blackWindow)
            window.addSubview(collectionView)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                self.blackWindow.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    func handleDismiss(){
        UIView.animate(withDuration: 0.5, animations: {
            self.blackWindow.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
        })
    }
    
    override init() {
        super.init()
    }
}
