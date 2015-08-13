//
//  NetManager.swift
//  summer
//
//  Created by Ding Soung on 15/5/26.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit
import AFNetworking

class AFNetManager {
	//AFNetworking 已经做好了任务调度 管理，不需要这里管理请求队列
	
    private var manager:AFHTTPRequestOperationManager?
    class var instance: AFNetManager {
        dispatch_once(&Inner.token){
            Inner.instance = AFNetManager()
        }
        return Inner.instance!
    }
    private struct Inner {
        static var instance:AFNetManager? = nil
        static var token: dispatch_once_t = 0
    }
    private init() {
        manager = AFHTTPRequestOperationManager()
    }
    
    //MARK: 基本的POST和GET
    func POST(url:String,parameter:AnyObject!, success:(AFHTTPRequestOperation, AnyObject) -> Void, fail:(AFHTTPRequestOperation, NSError) -> Void) {
		let url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
		manager?.POST(url, parameters: parameter, success: { (request, data) -> Void in
			success(request,data)
			}, failure: { (request, error) -> Void in
				fail(request, error)
		})
	}
    func GET(url:String,parameter:AnyObject?, success:(AFHTTPRequestOperation, AnyObject) -> Void, fail:(AFHTTPRequestOperation, NSError) -> Void) {
		let url = url.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
		manager?.GET(url, parameters: nil, success: { (request, data) -> Void in
			success(request,data)
			}, failure: { (request, error) -> Void in
				fail(request, error)
		})
	}
}

extension AFNetManager {
	//MARK: 字典传入
    func POST(url:String,parameter:Dictionary<String, AnyObject>,success:(data:AnyObject) -> (), fail:(error:NSError) -> Void) {
		//TODO: 转换parameter 为JSON
		self.POST(url, parameter: parameter, success: { (AFHTTPRequestOperation, AnyObject) -> Void in
			success(data: AnyObject)
			}) { (AFHTTPRequestOperation, NSError) -> Void in
				fail(error: NSError)
		}
	}
    //MARK: 简化的GET
    func GET(url:String, success:(data:AnyObject) -> (), fail:(error:NSError) -> Void) {
		self.GET(url, parameter: nil, success: { (request, data) -> Void in
			success(data: data)
			}) { (request, error) -> Void in
				fail(error: error)
		}
	}
}



