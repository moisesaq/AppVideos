//
//  MenuCell.swift
//  AppVideos
//
//  Created by Moises on 8/2/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class MenuCell: BaseCell{
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "home")
        //iv.tintColor = UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
        return iv
    }()
    
    override var isHighlighted: Bool{
        didSet{
            imageView.tintColor = isHighlighted ? .white : UIColor.menuCellNotSelected()
        }
    }
    
    override var isSelected: Bool{
        didSet{
            imageView.tintColor = isSelected ? .white : UIColor.menuCellNotSelected()
        }
    }
    
    override func setUpView() {
        super.setUpView()
        
        addSubview(imageView)
        
        addConstraintsWithFormat(format: "H:[v0(28)]", views: imageView)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
