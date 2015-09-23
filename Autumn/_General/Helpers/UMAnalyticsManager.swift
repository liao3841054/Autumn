//
//  UMengAnalyze.swift
//  Autumn
//
//  Created by Alex D. on 15/9/23.
//  Copyright © 2015年 Alex D. All rights reserved.
//

import UIKit


class UMAnalyticsManager {
    
    static let instance = UMAnalyticsManager()
    private init() {
        
        MobClick.startWithAppkey("55f93b13e0f55a3ced002115", reportPolicy: BATCH, channelId: "")
        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            MobClick.setAppVersion(version)
        }else{
            MobClick.setAppVersion("0.0.0")
        }
        MobClick.setEncryptEnabled(true)
        MobClick.setBackgroundTaskEnabled(true)
    }
}
