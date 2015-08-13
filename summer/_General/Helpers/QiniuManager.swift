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
    
    private var upManager:QNUploadManager?
    
   	class var instance: QiniuManager {
        dispatch_once(&Inner.token){
            Inner.instance = QiniuManager() //只初始化一次
        }
        return Inner.instance!
    }
    private struct Inner {
        static var instance:QiniuManager? = nil
        static var token: dispatch_once_t = 0
    }
    // 私有化构造方法，阻止其他对象使用这个类的默认的'()'构造方法
    private init() {
        upManager = QNUploadManager()
    }
    
    //MARK: 上传文件
    func upload(token:String, data:NSData, key:String,process:((percent:Float)->Void)?,complete:((key:String)->Void)?) {
        var opt = QNUploadOption(mime: nil, progressHandler: { (key, percent) -> Void in
            println(key)
            if percent < 1.0 {
                //进度
                process?(percent: percent)
            } else {
                //完成
                complete?(key: key)
            }
            }, params: ["x:foo" : "fooval"], checkCrc: true) { () -> Bool in
                //取消
                return false
        }
        upManager?.putData(data, key: key, token: token, complete: { (info, key, respDic) -> Void in
            println(info)
            println(key)
            println(respDic)
            }, option: opt)
    }
    //MARK: 断点续传
    func upload(folder:String, token:String, data:NSData, key:String, process:((percent:Float)->Void)?,complete:((key:String)->Void)?) {
        //写标记
        upManager = QNUploadManager(recorder: QNFileRecorder(folder: folder, error: NSErrorPointer()))
        self.upload(token, data: data, key: key, process: process) { (key) -> Void in
            //还原
            self.upManager = QNUploadManager() //还原
            complete
        }
    }
    
    //MARK: 简易版
    func upload(token:String, data:NSData, key:String) {
        self.upload(token, data: data, key: key, process: nil, complete: nil)
    }
    
    
}
