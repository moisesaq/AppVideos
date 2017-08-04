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
    
    func printData(){
        print("\(thumbnailImageName ?? "not fount") - \(title ?? "not fount") - \(String(describing: numberOfViews))")
    }
    
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
        dragonBallZVideo.title = "Dragon Ball Z - DragonBallZVEVO, the best :) test text 12345  asdasd"//"DragonBallZVEVO * 120.212.123 views * years ago - Watch it on cartoon network"
        dragonBallZVideo.thumbnailImageName = "dragon_ball_z"
        dragonBallZVideo.numberOfViews = 34242341234423
        dragonBallZVideo.channel = vegetaChannel
        
        return [dragonBallSuperVideo, dragonBallZVideo]
    }
    
    static func findVideos(completion: @escaping ([Video]) -> ()){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        var result: [Video] = []
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)

                for dictionary in json as! [[String: AnyObject]]{
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    
                    if let channelDictionary = dictionary["channel"] as? [String: AnyObject] {
                        let channel = Channel()
                        channel.name = channelDictionary["name"] as? String
                        channel.profileImageName = channelDictionary["profile_image_name"] as? String
                        video.channel = channel
                    }
                    
                    result.append(video)
                }
                
                completion(result)
            }catch let jsonError{
                print(jsonError)
            }
        }.resume()
    }
}

class Channel: NSObject{
    
    var name: String?
    var profileImageName: String?
}
