//
//  ShareData.swift
//  summer
//
//  Created by Ding Soung on 15/5/25.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

class ShareData {
	class var instance: ShareData {
		dispatch_once(&Inner.token){
			Inner.instance = ShareData() //只初始化一次
		}
		return Inner.instance!
	}
	private struct Inner {
		static var instance:ShareData? = nil
		static var token: dispatch_once_t = 0
	}
    
    var index:Int = 0
    // 私有化构造方法，阻止其他对象使用这个类的默认的'()'构造方法
	private init() {
        index = 1
	}
    func demoFunc(){
        index = index + 1
    }
}