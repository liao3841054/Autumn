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
    
    static let instance = QiniuManager()
    private init() {}
    var upManager = QNUploadManager()
    
    //MARK: 上传文件
    func upload(token:String, data:NSData, key:String,process:((percent:Float)->Void)?,complete:((key:String)->Void)?) {
        let opt = QNUploadOption(mime: nil, progressHandler: { (key, percent) -> Void in
            print(key)
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
            print(info)
            print(key)
            print(respDic)
            }, option: opt)
    }
    //MARK: 断点续传
    func upload(folder:String, token:String, data:NSData, key:String, process:((percent:Float)->Void)?,complete:((key:String)->Void)?) {
        //写标记
        upManager = QNUploadManager(recorder: QNFileRecorder(folder: folder))
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
