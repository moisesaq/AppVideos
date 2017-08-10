//
//  SettingCell.swift
//  AppVideos
//
//  Created by Moises on 8/8/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class SettingCell: BaseCell{
    
    override var isHighlighted: Bool{
        didSet{
            backgroundColor = isHighlighted ? .darkGray : .white
            
            nameLabel.textColor = isHighlighted ? .white : .darkGray
            
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
        }
    }
    var setting: Setting? {
        didSet{
            nameLabel.text = setting?.name.rawValue
            
            if let iconName = setting?.icon {
                iconImageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
                iconImageView.tintColor = .darkGray
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "setting")
        imageView.contentMode = .scaleToFill
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    
    override func setUpView() {
        super.setUpView()
        
        addSubview(iconImageView)
        addSubview(nameLabel)
        
        addConstraintsWithFormat(format: "H:|-10-[v0(28)]-10-[v1]|", views: iconImageView, nameLabel)
        
        addConstraintsWithFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithFormat(format: "V:[v0(28)]", views: iconImageView)
        
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
