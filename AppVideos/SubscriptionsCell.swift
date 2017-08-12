//
//  SubscriptionsCell.swift
//  AppVideos
//
//  Created by Moises on 8/12/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class SubscriptionsCell: HomeCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionsVideos(completion: { (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        })
    }
}
