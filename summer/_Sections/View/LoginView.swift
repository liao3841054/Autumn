//
//  LoginView.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit
import ReactiveCocoa

import CocoaAsyncSocket

class LoginView: UIView {
    
    @IBOutlet weak var mobile: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var register: UIButton!
    
    override func awakeFromNib() {
        
        //MARK: 过滤 text长度大于3时的信号 打印dat
        self.mobile.rac_textSignal().filter { (dat) -> Bool in
            self.mobile.textColor = (dat as! String).isMobileNumber ? UIColor.greenColor() : UIColor.grayColor()
            return (dat as! NSString).length > 3
            }.subscribeNext { (dat) -> Void in
                println(dat)
        }
        //MARK: 信号映射text 转为 NSNumber,  过滤number>3的信号  打印number
        self.passWord.rac_textSignal()
            .map { (dat) -> AnyObject! in
                return (dat as! NSString).length
            }.filter { (dat) -> Bool in
                self.passWord.textColor = (dat as! NSNumber).integerValue > 3 ? UIColor.greenColor() : UIColor.grayColor()
                return (dat as! NSNumber).integerValue > 3
            }.subscribeNext { (dat) -> Void in
                println(dat)
        }
        
        //MARK: 定义信号变量
        var vaidNameSignal = self.mobile.rac_textSignal().filter { (dat) -> Bool in
            return (dat as! String).isMobileNumber
        }
        let vaidPasswdSignal = self.passWord.rac_textSignal().filter { (dat) -> Bool in
            return count(dat as! String) > 4
        }
        //MARK: 信号聚合 过滤 产生功能
        #if false
        RACSignal.combineLatest([vaidNameSignal,vaidPasswdSignal])
            .filter { (signals) -> Bool in
                var allValid = true
                for signal in signals as! NSArray {
                    allValid = allValid && (signal as! Bool)
                }
                return allValid
            }.subscribeNext { (validMobildPassword) -> Void in
                self.signIn.enabled = (validMobildPassword as! Bool)
                self.signIn.setTitleColor((validMobildPassword as! Bool) ? UIColor.greenColor() : UIColor.grayColor(), forState: UIControlState.Normal)
        }
        #endif
        
        
        
        
        var signalA = RACSignal.createSignal { (subscriber) -> RACDisposable! in
            subscriber.sendNext("hello")
            return nil
        }
        signalA.map { (value) -> AnyObject! in
            if value as? String == "hello" {
                return "hi"
            }else{
                return ""
            }
        }
        
        
        /*
        #if false //RAC 宏定义在swift中不可用
            RAC(self.name.backgroundColor) = vaidNameSignal.map({ (dat) -> AnyObject! in
            return (dat as! Bool) ? UIColor.clearColor() : UIColor.whiteColor()
            })
            #else
            vaidNameSignal.map { (dat) -> AnyObject! in
                return (dat as! Bool) ? UIColor.clearColor() : UIColor.yellowColor()
                }.subscribeNext { (dat) -> Void in
                    self.signIn.backgroundColor = (dat as! UIColor)
            }
        #endif
        vaidPasswdSignal.map { (dat) -> AnyObject! in
            return (dat as! Bool) ? UIColor.clearColor() : UIColor.yellowColor()
            }.subscribeNext { (dat) -> Void in
                self.passWord.backgroundColor = (dat as! UIColor)
        }*/
        
        //MARK: Login
        self.signIn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (dat) -> Void in
            var urlArray = ["http://e.hiphotos.baidu.com/image/pic/item/b2de9c82d158ccbfa0345b821bd8bc3eb03541fa.jpg",
            "http://h.hiphotos.baidu.com/image/pic/item/f11f3a292df5e0febe8bd3005e6034a85edf721b.jpg",
            "http://g.hiphotos.baidu.com/image/pic/item/e1fe9925bc315c60f2148de58fb1cb1349547733.jpg",
            "http://h.hiphotos.baidu.com/image/pic/item/962bd40735fae6cd9caa64690db30f2442a70f98.jpg"]
            
            #if false
            let vc = AlbumViewController()
            vc.urlArray = urlArray
            self.delegate?.presentViewController(vc, animated: true) { () -> Void in
            }
            #else
                var v = AlbumView(frame: self.frame)
                v.urlArray = urlArray
                (UIApplication.sharedApplication().delegate as? AppDelegate)?.window!.rootViewController?.view.addSubview(v)
            #endif
        }
        //MARK: Register
        self.register.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (dat) -> Void in
            self.superViewController?.navigationController?.pushViewController(UIViewController(), animated: true)
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
}
