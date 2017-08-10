//
//  Setting.swift
//  AppVideos
//
//  Created by Moises on 8/8/17.
//  Copyright © 2017 Moises. All rights reserved.
//

import Foundation

class Setting {
    let name: SettingName
    let icon: String
    
    init(name: SettingName, icon: String) {
        self.name = name
        self.icon = icon
    }
    
    static func getSettingList() -> [Setting]{
        return [Setting(name: .settings, icon: "setting"),
                Setting(name: .termPrivacy, icon: "privacy"),
                Setting(name: .feedback, icon: "feedback"),
                Setting(name: .help, icon: "help"),
                Setting(name: .switchAccount, icon: "switch_account"),
                Setting(name: .cancel, icon: "cancel")]
    }
}

enum SettingName: String {
    case settings = "Settings"
    case termPrivacy = "Terms & Privacy"
    case feedback = "Send feedback"
    case help = "Help"
    case switchAccount = "Switch account"
    case cancel = "Cancel"
}
