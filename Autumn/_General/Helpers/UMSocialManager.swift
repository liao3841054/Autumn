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
        
        UMSocialData.setAppKey("55f93b13e0f55a3ced002115")
        
        UMSocialWechatHandler.setWXAppId("wxd930ea5d5a258f4f", appSecret: "db426a9829e4b49a0dcac7b4162da6b6", url: "http://www.umeng.com/social")
        
        UMSocialQQHandler.setQQWithAppId("100424468", appKey: "c7394704798a158208a74ab60104f0ba", url: "http://www.umeng.com/social")
    }
    
    internal func authorize(presentingController:UIViewController,socialPlatform:String, success:(account:UMSocialAccountEntity)->Void, fail:(error:NSError)->Void) {
        let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(socialPlatform)
        snsPlatform.loginClickHandler(presentingController,UMSocialControllerService.defaultControllerService(),true, {(response:UMSocialResponseEntity!) in
            if response.responseCode == UMSResponseCodeSuccess {
                if let snsAccount = (UMSocialAccountManager.socialAccountDictionary() as NSDictionary).valueForKey(socialPlatform) as? UMSocialAccountEntity {
                    success(account: snsAccount)
                } else {
                    fail(error: NSError(domain: "UMSocialAccountEntity解析错误", code: -1, userInfo: ["data":response]))
                }
            } else {
                fail(error: NSError(domain: "UMSocialResponseEntity解析错误", code: -1, userInfo: ["data":response]))
            }
        })
    }
    
    internal func requestWechatInfo(socoalPlatform:String) {
        UMSocialDataService.defaultDataService().requestSnsInformation(socoalPlatform) { (response: UMSocialResponseEntity!) -> Void in
            print(response.data)
        }
    }
    
    
    //MARK: others
    /*
    //request info
    UMSocialDataService.defaultDataService().requestSnsInformation(socoalPlatform) { (response: UMSocialResponseEntity!) -> Void in
    print(response.data)
    }
    //share
    UMSocialDataService.defaultDataService().postSNSWithTypes(<#T##platformTypes: [AnyObject]!##[AnyObject]!#>, content: <#T##String!#>, image: <#T##AnyObject!#>, location: <#T##CLLocation!#>, urlResource: <#T##UMSocialUrlResource!#>, presentedController: <#T##UIViewController!#>, completion: <#T##UMSocialDataServiceCompletion!##UMSocialDataServiceCompletion!##(UMSocialResponseEntity!) -> Void#>)
    
    
    */
}
