//
//  Extensions.swift
//  AppVideos
//
//  Created by Moises on 8/2/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import UIKit

extension UIColor{
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor{
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    //COLOR FOR NAVIGATION BAR
    static func redNavigationBar() -> UIColor{
        return UIColor.rgb(red: 230, green: 32, blue: 31, alpha: 1)
    }
    
    //COLOR FOR STYLE STATUS BAR
    static func redStatusBar() -> UIColor{
        return UIColor.rgb(red: 194, green: 31, blue: 31, alpha: 1)
    }
    
    //COLOR FOR STYLE STATUS BAR
    static func menuCellNotSelected() -> UIColor{
        return UIColor.rgb(red: 91, green: 14, blue: 13, alpha: 1)
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

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView{
    
    var imageUrlString: String?
    
    func loadImageWithUrlString(urlString: String){
        
        imageUrlString = urlString
        
        image = nil

        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = imageFromCache
            return
        }
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                //self.image = UIImage(named: "dragon_ball_z")
                return
            }
            
            DispatchQueue.main.async {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                //self.image = UIImage(data: data!)
            }
        }).resume()
    }
}
