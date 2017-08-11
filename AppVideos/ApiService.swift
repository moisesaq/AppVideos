//
//  ApiService.swift
//  AppVideos
//
//  Created by Moises on 8/10/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

class ApiService: NSObject {

    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()){
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        
        var result = [Video]()
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
                DispatchQueue.main.async {
                    completion(result)
                }
            }catch let jsonError{
                print(jsonError)
            }
            }.resume()
    }
}
