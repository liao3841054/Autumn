//
//  Appdelegate+UMSocialManager.swift
//  Autumn
//
//  Created by Alex D. on 15/9/24.
//  Copyright © 2015年 Alex D. All rights reserved.
//

extension AppDelegate {
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
}