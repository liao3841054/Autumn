//
//  ShareData.swift
//  summer
//
//  Created by Ding Soung on 15/5/25.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class ShareData {
	
	var index:Int = 0
	
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
	private init() {
        index = 1
	}
    func demoFunc(){
        index = index + 1
    }
}
