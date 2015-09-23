//
//  LoginViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit
import AVFoundation

import MobileCoreServices
//import CocoaLumberjack

import AssetsLibrary

class MyViewController: BaseViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate, QRCodeReaderViewControllerDelegate {
    
    private var showSectionBlock: ((view:UIView)->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //MARK: GCD异步延时
        _ = GCDManager.delay(0.8, task: { () -> () in
            print("task start", terminator: "")
        })
        //GCDManager.cancel(task)
        
        //MARK: 模块化
        closure("描述下面这段代码的功能", run: true, block: { () -> Void in
            print("closure start")
            }) { () -> Void in
                print("clisure complite")
        }
        
        //MARK: 单例测试
        print(ShareData.instance.index)
        ShareData.instance.index = ShareData.instance.index + 1
        print(ShareData.instance.index)
        ShareData.instance.demoFunc()
        
        //MARK: 最简swift单例
        ShareModel.instance.function()
        
        //MARK: 设置阴影
        let view = UIButton(frame: CGRectMake(self.view.frame.size.width - 50 - 10, 40, 50, 50))
        view.backgroundColor = UIColor.greenColor()
        view.setShadow(UIColor.yellowColor().CGColor, offset: CGSizeMake(5, 5), opacity: 0.5, radius: 10)
        self.view.addSubview(view)
        //MARK: 全屏显示
        view.viewInFullScreen()
        
        //MARK: 本地推送消息
        NotificationManager.instance.scheduleNotification(123, delaySeconds: 3, timeZone: NSTimeZone.defaultTimeZone(), message: "本地消息")
        //cancelNotification(123);
    }
    
    @IBAction func loginBtnAction(sender: AnyObject) {
        _ = LoginViewController()
        let navi = UINavigationController(rootViewController: LoginViewController())
        self.presentViewController(navi, animated: true, completion: nil)
    }
    @IBAction func httpDebugBtnAction(sender: AnyObject) {
        let vc = UINavigationController(rootViewController: HTTPDebugViewController())
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func 摄像头录制视频(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let picker = UIImagePickerController()
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
            print("Camera is not available")
        }
    }
    @IBAction func 摄像头拍照(sender: UIButton) {
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
    }
    @IBAction func Library读取视频(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            picker.mediaTypes = [kUTTypeMovie as String]
            picker.delegate = self
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else {
            print("Library is not available")
        }
    }
    @IBAction func 测试七牛上传(sender: UIButton) {
        QiniuManager.instance.upload("tolken form server", data: NSData(), key: "test key")
    }
    
    @IBAction func 测试JavaScriptManager(sender: UIButton) {
        if let  path = NSBundle.mainBundle().pathForResource("test", ofType: "js") {
            do {
                let js = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
                print(JavaScriptManager.instance.runJS(js, function: "factorial", parameter: [10]))
            } catch {
                print(error)
            }
        }
    }
    
    @IBAction func 测试WebViewToolsJS扩展(sender: UIButton) {
        if let path = NSBundle.mainBundle().pathForResource("test", ofType: "html") {
            do {
                let html = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding) as String
                let web = UIWebView(frame: self.view.frame)
                self.view.addSubview(web)
                web.loadHTMLString(html, baseURL: NSURL(fileURLWithPath: path))
                web.setJS("btnClicked", block: { (str) -> Void in
                    let alert = UIAlertView(title: "", message: "js call native block", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                    web.removeFromSuperview()
                })
            } catch {
                print(error)
            }
        }
    }
    @IBAction func 测试二维码(sender: UIButton) {
        let reader = QRCodeReaderViewController(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
        reader.delegate = self
        
        // Or by using the closure pattern
        reader.completionBlock = { (result: String?) in
            print(result)
        }
        
        // Presents the reader as modal form sheet
        reader.modalPresentationStyle = .FormSheet
        self.presentViewController(reader, animated: true, completion: nil)
    }
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(reader: QRCodeReaderViewController, didScanResult result: String) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func readerDidCancel(reader: QRCodeReaderViewController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: ImagePicker delegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        closure("保存视频", run: true, block: { () -> Void in
            if info[UIImagePickerControllerMediaType] as? String == kUTTypeMovie as String {
                self.closure("方法1", run: true, block: { () -> Void in
                    if let path = (info[UIImagePickerControllerMediaURL] as? NSURL)?.relativePath {
                        self.dismissViewControllerAnimated(true, completion: nil)
                        UISaveVideoAtPathToSavedPhotosAlbum(path, self, nil, nil)
                    }
                })
                self.closure("方法2", run: false, block: { () -> Void in
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
        print("image load success")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        print("image load fail")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}














