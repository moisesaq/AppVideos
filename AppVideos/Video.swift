//
//  Video.swift
//  AppVideos
//
//  Created by Moises on 8/3/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

//TODO: Finish this with video tutorial cap 15
class SafeJsonObject: NSObject{
    override func setValue(_ value: Any?, forKey key: String) {
        //let uppercasedFirstCharacter = String(key.characters.first!).uppercased()
        //let range = key.startIndex...key.startIndex[0]
    }
}

class Video: NSObject{
    
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber?
    //var upload_date: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    init(dictionary: [String: AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "channel" {
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: AnyObject])
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
    func printData(){
        print("\(thumbnail_image_name ?? "not fount") - \(title ?? "not fount") - \(String(describing: number_of_views))")
    }
}

class Channel: NSObject{
    var name: String?
    var profile_image_name: String?
}
