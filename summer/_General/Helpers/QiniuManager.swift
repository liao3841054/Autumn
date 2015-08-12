//
//  QiniuManager.swift
//  summer
//
//  Created by Alex D. on 15/8/12.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit
import Qiniu

class QiniuManager {
    
    var uploadManager:QNUploadManager?
    
   	class var instance: NotificationManager {
        dispatch_once(&Inner.token){
            Inner.instance = NotificationManager() //只初始化一次
        }
        return Inner.instance!
    }
    private struct Inner {
        static var instance:NotificationManager? = nil
        static var token: dispatch_once_t = 0
    }
    
    
    init() {
        uploadManager = QNUploadManager()
    }
    
    func upload(data:NSData,key:String){
        uploadManager?.putData(data, key: key, token: "从服务端SDK获取", complete: { (info, key, respDic) -> Void in
            println(info)
            println(respDic)
            }, option: QNUploadOption.defaultOptions())
    }
    
    /*
    NSString token = @"从服务端SDK获取";
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    NSData *data = [@"Hello, World!" dataUsingEncoding : NSUTF8StringEncoding];
    [upManager putData:data key:@"hello" token:token
    complete: ^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
    NSLog(@"%@", info);
    NSLog(@"%@", resp);
    } option:nil];
    */
}
