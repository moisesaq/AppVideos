//
//  TrendingCell.swift
//  AppVideos
//
//  Created by Moises on 8/12/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class TrendingCell: HomeCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingVideos(){ (videos: [Video]) in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
