//
//  VideoCell.swift
//  AppVideos
//
//  Created by Moises on 8/1/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class VideoCell: BaseCell {
    
    var video: Video?{
        didSet{
            titleLabel.text = video?.title
            loadthumbnailImage()
            loadProfileImage()
            showChannelData()
        }
    }
    
    func loadthumbnailImage(){
        guard let thumbnailImageURL = video?.thumbnail_image_name else { return }
        
        self.thumbnailImageView.loadImageWithUrlString(urlString: thumbnailImageURL)
    }
    
    func loadProfileImage(){
        guard let profileImageURL = video?.channel?.profile_image_name else { return }
        
        self.profileImageView.loadImageWithUrlString(urlString: profileImageURL)
    }
    
    func showChannelData(){
        if let channelName = video?.channel?.name, let numberOfViews = video?.number_of_views {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let subtitleText = "\(channelName) * \(numberFormatter.string(from: numberOfViews)!) * 2 years ago - Coming soon in cartoon network"
            subtitleTextView.text = subtitleText
        }
        
        //MEASURE TITLE TEXT
        if let title = video?.title {
            let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000) //height is arbitrary
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimateRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            
            //print("\(String(describing: video?.title)) >>> \(estimateRect.size.width)")
            if estimateRect.size.width > 280 {
                titleLabelHeightConstraint.constant = 44
            }else{
                titleLabelHeightConstraint.constant = 20
            }
            
        }
    }

    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "dragon_ball_super")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.image = UIImage(named: "logo")
        imageView.layer.cornerRadius = 22 //22 because the size of imageView is 44
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill //keep the scale image original
        return imageView
    }()
    
    let separeteView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Goku - Dragon ball Super"
        label.translatesAutoresizingMaskIntoConstraints = false;
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false;
        textView.text = "DragonBallSuperVEVO * 5.343.212.123 views * years ago - Coming soon in cartoon network"
        textView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textView.textColor = .lightGray
        return textView
    }()
    
    override func setUpView(){
        super.setUpView()
        addSubview(thumbnailImageView)
        addSubview(separeteView)
        addSubview(profileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraintsWithFormat(format: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraintsWithFormat(format: "H:|-16-[v0(44)]", views: profileImageView)
        
        //Vertical constraints
        addConstraintsWithFormat(format: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, profileImageView, separeteView)
        
        addConstraintsWithFormat(format: "H:|[v0]|", views: separeteView)
        
        alignTitleLabel()
        alignSubtitleTextView()
    }
    
    var titleLabelHeightConstraint = NSLayoutConstraint()
    
    fileprivate func alignTitleLabel(){
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8))
        
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        
        //height constraint
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
        addConstraint(titleLabelHeightConstraint)
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
