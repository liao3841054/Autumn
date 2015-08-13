//
//  SignInService.swift
//  summer
//
//  Created by Ding Soung on 15/5/31.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class CertificateModel {
    
    private var index:Int!
    
    class var instance: CertificateModel {
        dispatch_once(&Inner.token){
            Inner.instance = CertificateModel() //只初始化一次
        }
        return Inner.instance!
    }
    private struct Inner {
        static var instance:CertificateModel? = nil
        static var token: dispatch_once_t = 0
    }
    private init() {
        index = 0
    }
    
	func signInWithNamePassWD(name:String, passWD:String, success: (Bool) -> Void){
		let result = true
		success(result)
	}
   
}
