//
//  UMSocialManager.swift
//  Autumn
//
//  Created by Alex D. on 15/9/23.
//  Copyright © 2015年 Alex D. All rights reserved.
//

import UIKit

class UMSocialManager: NSObject {
    static let instance = UMSocialManager()
    private override init() {
        super.init()
        
        UMSocialWechatHandler.setWXAppId("wxebb3f06d7fe3352d", appSecret: "71d4bc6e1a403cb7473abb212e69530c", url: "http://www.xinyihezi.com")
    }
    
    func authorize(presentingController:UIViewController,socoalPlatform:String, success:(account:UMSocialAccountEntity)->Void, fail:(error:NSError)->Void) {
        let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(socoalPlatform)
        snsPlatform.loginClickHandler(presentingController,UMSocialControllerService.defaultControllerService(),true, {(response:UMSocialResponseEntity!) in
            if response.responseCode == UMSResponseCodeSuccess {
                if let snsAccount = (UMSocialAccountManager.socialAccountDictionary() as NSDictionary).valueForKey(socoalPlatform) as? UMSocialAccountEntity {
                    //print(snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL)
                    success(account: snsAccount)
                } else {
                    fail(error: NSError(domain: "UMSocialAccountEntity解析错误", code: -1, userInfo: ["data":response]))
                }
            } else {
                fail(error: NSError(domain: "UMSocialResponseEntity解析错误", code: -1, userInfo: ["data":response]))
            }
        })
    }
    
    func requestWechatInfo() {
        UMSocialDataService.defaultDataService().requestSnsInformation(UMShareToWechatSession) { (response: UMSocialResponseEntity!) -> Void in
            print(response.data)
        }
    }
}
