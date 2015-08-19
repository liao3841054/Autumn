//
//  NetManager.swift
//  summer
//
//  Created by Ding Soung on 15/5/26.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit
import AFNetworking


enum ContentTypes: String {
    case textHTML = "text/html"
    case applicationJSON = "application/json"
}


class NetManager {
    //AFNetworking 已经做好了任务调度 管理，不需要这里管理请求队列
    
    var manager:AFHTTPSessionManager?
    class var instance: NetManager {
        dispatch_once(&Inner.token){
            Inner.instance = NetManager()
        }
        return Inner.instance!
    }
    private struct Inner {
        static var instance:NetManager? = nil
        static var token: dispatch_once_t = 0
    }
    private init() {
        manager = AFHTTPSessionManager()
        manager?.responseSerializer.acceptableContentTypes = Set(arrayLiteral: "text/html")
    }
    
    private func afnetworkConfig(type:ContentTypes?) -> Void {
        if let type = type {
            manager?.responseSerializer.acceptableContentTypes = Set(arrayLiteral: type.rawValue)
        }
    }
    
    //MARK: 基本的POST和GET
    func POST(type:ContentTypes?,url:String,parameter:AnyObject!, success:((NSURLSessionDataTask, AnyObject) -> Void)!, fail:((NSURLSessionDataTask, NSError) -> Void)!) {
        self.afnetworkConfig(type)
        manager?.POST(url, parameters: parameter, success: { (task, data) -> Void in
            success(task, data)
            }, failure: { (task, error) -> Void in
                fail(task, error)
        })
    }
    /*
    func GET(type:ContentTypes?,url:String, success:(NSURLSessionDataTask, AnyObject) -> Void, fail:(NSURLSessionDataTask, NSError) -> Void) {
        self.afnetworkConfig(type)
        manager?.GET(url, parameters: nil, success: { (task, data) -> Void in
            success(task, data)
            }, failure: { (task, error) -> Void in
                fail(task, error)
        })
    }*/
}

extension NetManager {
    
    //MARK: 字典传入
    /*
    func POST(type:ContentTypes?,url:String,JSON:Dictionary<String, AnyObject>?,success:(data:AnyObject) -> (), fail:(error:NSError) -> Void) {
        //TODO: 转换parameter 为JSON
    }*/
    //MARK: 简化的GET
    /*
    func GET(type:ContentTypes?,url:String, success:(data:AnyObject) -> Void, fail:(error:NSError) -> Void) {
    }*/
}



