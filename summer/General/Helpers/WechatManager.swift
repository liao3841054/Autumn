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

protocol wechatAPIDelegate {
	func wechatAPIget(openID:String)
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
	
	
	
	//WeChat func
	func weChatShareMessage(message:String){
		if(WXApi.isWXAppInstalled() != true) {
			return
		}
		var req = SendMessageToWXReq()
		req.scene = Int32(WXSceneSession.value)
		req.text = "test weChat Share"
		req.bText = true
		WXApi.sendReq(req)
	}
	func weChatOpenID(){
		/*
		var req = SendAuthReq()
		req.scope = "snsapi_userinfo"
		req.state = "wechat_sdk_demo"  //"73746172626f796368696e61"//于防止csrf攻击
		WXApi.sendReq(req)
		*/
	}
	
	//weChat Protocol
	func onReq(req: BaseReq!) { // to weChat
		print(req.openID)
	}
	
	func onResp(resp: BaseResp!) { // from weChat
		if resp.isKindOfClass(PayResp) {
			if let temp = resp as? PayResp {
				//支付的回调
			}
		}
		if (resp.isKindOfClass(SendAuthResp)) {
			if let temp = resp as? SendAuthResp {
				var url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
					+ "appid=" + weChatAppID
					+ "&secret=" + weChatAppSecret
					+ "&code=" + temp.code
					+ "&grant_type=authorization_code"
				/*
				request openID with url request
				netAPI.httpGet(url, parameter: nil, httpHandler: { (data) -> Void in
					if let openid = ((data as? NSDictionary)?.valueForKey("openid")) as? String {
						//TODO: 这里跳不回去   使用广播传递open ID 带本地再跳回去
						NSNotificationCenter.defaultCenter().postNotificationName("getWechatOpenid:", object: openid)
					}
				})*/
			}
		}
	}
	func getWechatOpenid(notifi: NSNotification){
		if let openid = notifi.object as? String {
			self.delegate?.wechatAPIget(openid)
		}
	}
	
	
	func didGetWechatOpenid(notifi: NSNotification) {
		var resp = notifi.object as? BaseResp
		/*
		if let temp = resp as? SendAuthResp {
		var url = "https://api.weixin.qq.com/sns/oauth2/access_token?"
		+ "appid=" + weChatAppID
		+ "&secret=" + weChatAppSecret
		+ "&code=" + temp.code
		+ "&grant_type=authorization_code"
		netAPI.httpGet(url, parameter: nil, httpHandler: { (data) -> Void in
		if let openid = ((data as? NSDictionary)?.valueForKey("openid")) as? String {
		self.delegate?.wechatAPIget(openid)
		}
		})
		}
		*/
	}
}

