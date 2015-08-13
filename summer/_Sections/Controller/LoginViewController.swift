//
//  LoginViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit

import MobileCoreServices
import AssetsLibrary

class LoginViewController: BaseNaviViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let v = (NSBundle.mainBundle().loadNibNamed("LoginView", owner: self, options: nil) as NSArray).lastObject as? LoginView {
            v.frame = self.view.frame
            self.view.addSubview(v)
        }
        
        //MARK: GCD异步延时
        _ = GCDManager.delay(0.8, task: { () -> () in
            print("task start", appendNewline: false)
        })
        //GCDManager.cancel(task)
        
        //MARK: 模块化
        closure(mark: "描述下面这段代码的功能", run: true, block: { () -> Void in
            println("closure start")
            }) { () -> Void in
                println("clisure complite")
        }
        
        //MARK: 单例测试
        println(ShareData.instance.index)
        ShareData.instance.index = ShareData.instance.index + 1
        println(ShareData.instance.index)
        ShareData.instance.demoFunc()
        
        //MARK: 设置阴影
        let view = UIButton(frame: CGRectMake(40, 40, 50, 50))
        view.backgroundColor = UIColor.greenColor()
        view.setShadow(color: UIColor.yellowColor().CGColor, offset: CGSizeMake(5, 5), opacity: 0.5, radius: 10)
        self.view.addSubview(view)
        //MARK: 全屏显示
        view.viewInFullScreen()
        
        //MARK: 本地推送消息
        NotificationManager.instance.scheduleNotification(itemID: 123, delaySeconds: 3, timeZone: NSTimeZone.defaultTimeZone(), message: "本地消息")
        //cancelNotification(123);
        
        
        
        closure(mark: "摄像头录制视频", run: false, block: { () -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
                var picker = UIImagePickerController()
                picker.delegate = self
                
                picker.sourceType = UIImagePickerControllerSourceType.Camera
                picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                picker.allowsEditing = true
                picker.showsCameraControls = true
                
                picker.mediaTypes = [kUTTypeMovie as String]
                picker.videoQuality = UIImagePickerControllerQualityType.Type640x480
                picker.videoMaximumDuration = 10.0
                
                self.presentViewController(picker, animated: true, completion: nil)
            }
            else {
                println("Camera is not available")
            }
            }, complete: nil)
        
        closure(mark: "Library 读取视频", run: false, block: { () -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
                var picker = UIImagePickerController()
                picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                picker.mediaTypes = [kUTTypeMovie as String]
                picker.delegate = self
                self.presentViewController(picker, animated: true, completion: nil)
            }
            else {
                println("Library is not available")
            }
        })
        
        closure(mark: "摄像头拍照", run: false, block: { () -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
                let picker = UIImagePickerController()
                picker.delegate = self
                
                picker.sourceType = UIImagePickerControllerSourceType.Camera
                picker.cameraDevice = UIImagePickerControllerCameraDevice.Front
                picker.allowsEditing = true
                

                self.presentViewController(picker, animated: true, completion: nil)
            } else {
                let alert = UIAlertView(title: "", message: "相机已被禁用，请在设置中设置允许", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
        
        
        closure(mark: "测试七牛上传", run: true, block: { () -> Void in
            QiniuManager.instance.upload("tolken form server", data: NSData(), key: "test key")
        })
    }
    
    //MARK: ImagePicker delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        closure(mark: "保存视频", run: true, block: { () -> Void in
            if info[UIImagePickerControllerMediaType] as? String == kUTTypeMovie as String {
                self.closure(mark: "方法1", run: true, block: { () -> Void in
                    if let path = (info[UIImagePickerControllerMediaURL] as? NSURL)?.relativePath {
                        self.dismissViewControllerAnimated(true, completion: nil)
                        UISaveVideoAtPathToSavedPhotosAlbum(path, self, nil, nil)
                    }
                })
                self.closure(mark: "方法2", run: false, block: { () -> Void in
                    if let url = info[UIImagePickerControllerMediaURL] as? NSURL {
                        ALAssetsLibrary().writeVideoAtPathToSavedPhotosAlbum(url, completionBlock: { (url, error) -> Void in
                        })
                    }
                    
                })
            }
            picker.dismissViewControllerAnimated(true, completion: nil)
        })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        println("image load success")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        println("image load fail")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
