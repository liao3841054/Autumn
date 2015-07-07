//
//  SignInService.swift
//  summer
//
//  Created by Ding Soung on 15/5/31.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class CertificateModel {
    
    var index:Int!
    
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
    
    init() {
        index = 0
    }
    
    
    
	func signInWithNamePassWD(name:String, passWD:String, success: (Bool) -> Void){
		var result = true
		success(result)
	}
   
}
