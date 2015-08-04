//
//  WechatManager.swift
//
//
//  Created by Ding Soung on 15/6/23.
//
//

import UIKit

/*
depends
1. add Wechat SDK 1.5
2. import UIKit, WXApi.h, WXApiObject.h to bridge header
3. add SystemConfiguration.framework,libz.dylib,libsqlite3.0.dylib, libc++.dylib to workspwce/project
*/

@objc protocol wechatAPIDelegate {
	optional func weChat(openid:String)
}

class WechatManager {
	class var instance: WechatManager {
		dispatch_once(&Inner.token) {
			Inner.instance = WechatManager()
		}
		return Inner.instance!
	}
	private struct Inner {
		static var instance: WechatManager?
		static var token: dispatch_once_t = 0
	}
	
	var delegate: wechatAPIDelegate?
	private let weChatAppID = "wxd642344836a4b74d"
	private let weChatAppSecret = "2b35f41b291b35bd84241a2c45088318"
	
	init() {
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "didGetWechatOpenid:", name: "getWechatOpenid", object: nil)
		WXApi.registerApp(weChatAppID)
	}
	
	
	func wechatIsInstalled() -> Bool {
		return WXApi.isWXAppInstalled()
	}
	func wechatAuthShare(message:String){
		let req = SendMessageToWXReq()
		req.scene = Int32(WXSceneSession.rawValue)
		req.text = "test weChat Share"
		req.bText = true
		WXApi.sendReq(req)
	}
	func wechatAuth() {
		let req = SendAuthReq()
		req.scope = "snsapi_userinfo"
		req.state = "wechat_sdk_demo"  //"73746172626f796368696e61"//于防止csrf攻击
		WXApi.sendReq(req)
	}
	
	
	//MARK: WeChat call Back
	 //to weChat
	func onReq(req: BaseReq!) {
		print(req.openID)
	}
	
	//from weChat
	func onResp(resp: BaseResp!) {
		if resp.isKindOfClass(PayResp) {
			if let _ = resp as? PayResp {
				//支付的回调
			}
		}
		
		if (resp.isKindOfClass(SendAuthResp)) {
			if let temp = resp as? SendAuthResp {
				let url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
					+ "appid=" + weChatAppID
					+ "&secret=" + weChatAppSecret
					+ "&code=" + temp.code
					+ "&grant_type=authorization_code"
				AFNetManager.GET(url, success: { (data) -> () in
					if let v = (data as? NSDictionary)?.valueForKey("openid") as? String {
						//NSNotificationCenter.defaultCenter().postNotificationName("wechatOnResp:", object: nil, userInfo: ["openid" : v])
						self.delegate?.weChat!(v)
					}
				}, fail: { (error) -> Void in
					//
				})
			}
		}
	}
	
	//func wechatOnResp(notifi: NSNotification) {
	//}
}

