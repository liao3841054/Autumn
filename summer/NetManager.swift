//
//  NetManager.swift
//  summer
//
//  Created by Ding Soung on 15/5/26.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit
import AFNetworking

class NetManager {
	class func POST(url:String,parameter:AnyObject?, success:(AFHTTPRequestOperation, AnyObject) -> Void, fail:(AFHTTPRequestOperation, NSError) -> Void) {
		let url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
		let manager = AFHTTPRequestOperationManager()
		if let para: AnyObject = parameter {
			manager.POST(url, parameters: para, success: { (request, data) -> Void in
				success(request,data)
			}, failure: { (request, error) -> Void in
				fail(request, error)
			})
		}else{

		}
	}
	class func GET(url:String,parameter:AnyObject?, success:(AFHTTPRequestOperation, AnyObject) -> Void, fail:(AFHTTPRequestOperation, NSError) -> Void) {
		let url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
		let manager = AFHTTPRequestOperationManager()
		manager.GET(url, parameters: nil, success: { (request, data) -> Void in
			success(request,data)
			}, failure: { (request, error) -> Void in
				fail(request, error)
		})
	}
}

extension NetManager {
	typealias Success = (data:AnyObject) -> ()
	typealias Fail = (error:NSError) -> Void
	
	class func POST(url:String,parameter:[String:AnyObject],success:Success, fail:Fail) {
		//TODO 转换parameter 为JSON
		self.POST(url, parameter: parameter, success: { (AFHTTPRequestOperation, AnyObject) -> Void in
			success(data: AnyObject)
			}) { (AFHTTPRequestOperation, NSError) -> Void in
				fail(error: NSError)
		}
	}
	class func GET(url:String, success:Success, fail:Fail) {
		self.GET(url, parameter: nil, success: { (request, data) -> Void in
			success(data: data)
			}) { (request, error) -> Void in
				fail(error: error)
		}
	}
}
