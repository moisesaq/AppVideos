//
//  Video.swift
//  AppVideos
//
//  Created by Moises on 8/3/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class Video: NSObject{
    
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
    var channel: Channel?
    
    static func testVideosDragonBall() -> [Video]{
        let vegetaChannel = Channel()
        vegetaChannel.name = "Vegeta"
        vegetaChannel.profileImageName = "vegeta"
        
        let dragonBallSuperVideo = Video()
        dragonBallSuperVideo.title = "Dragon Ball Super"//"DragonBallSuperVEVO * 5.212.123 views * years ago - Coming soon on cartoon network"
        dragonBallSuperVideo.thumbnailImageName = "dragon_ball_super"
        dragonBallSuperVideo.numberOfViews = 12334534123
        dragonBallSuperVideo.channel = vegetaChannel
        
        let dragonBallZVideo = Video()
        dragonBallZVideo.title = "Dragon Ball Z - DragonBallZVEVO, the best :)"//"DragonBallZVEVO * 120.212.123 views * years ago - Watch it on cartoon network"
        dragonBallZVideo.thumbnailImageName = "dragon_ball_z"
        dragonBallZVideo.numberOfViews = 34242341234423
        dragonBallZVideo.channel = vegetaChannel
        
        return [dragonBallSuperVideo, dragonBallZVideo]
    }
}

class Channel: NSObject{
    
    var name: String?
    var profileImageName: String?
}
