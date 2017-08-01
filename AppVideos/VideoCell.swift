//
//  VideoCell.swift
//  AppVideos
//
//  Created by Moises on 8/1/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dragon_ball_super")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let separeteView: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Goku - Dragon ball Super"
        label.translatesAutoresizingMaskIntoConstraints = false;
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.text = "DragonBallSuperVEVO * 5.343.212.123 views * years ago - test completed"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    func setUp(){
        addSubview(thumbnailImageView)
        addSubview(separeteView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        
        //Vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, profileImageView, separeteView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separeteView)
        
        alignTitleLabel()
        alignSubtitleTextView()
    }
    
    fileprivate func alignTitleLabel(){
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20))
    }
    
    fileprivate func alignSubtitleTextView(){
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
    }
}


extension UIView{
    
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
