//
//  Setting.swift
//  AppVideos
//
//  Created by Moises on 8/8/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import Foundation

class Setting {
    let name: String
    let icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    static func getSettingList() -> [Setting]{
        return [Setting(name: "Settings", icon: "setting"),
                Setting(name: "Terms & privacy policy", icon: "privacy"),
                Setting(name: "Send Feedback", icon: "feedback"),
                Setting(name: "Help", icon: "help"),
                Setting(name: "Switch account", icon: "switch_account"),
                Setting(name: "Cancel", icon: "cancel")]
    }
}
