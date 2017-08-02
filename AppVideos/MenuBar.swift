//
//  MenuBar.swift
//  AppVideos
//
//  Created by Moises on 8/2/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class MenuBar: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    private func setUpView(){
        backgroundColor = UIColor.redNavigationBar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
