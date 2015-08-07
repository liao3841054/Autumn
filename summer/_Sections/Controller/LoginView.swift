//
//  LoginView.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit
import ReactiveCocoa

class LoginView: UIView {
    
    var delegate:UIViewController?
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var register: UIButton!
    
    override func awakeFromNib() {
        /*
        //MARK: 过滤 text长度大于3时的信号 打印dat
        self.userName.rac_textSignal().filter { (dat) -> Bool in
            self.userName.backgroundColor = count(dat as! String) > 3 ? UIColor.whiteColor() : UIColor.yellowColor()
            return (dat as! NSString).length > 3
            }.subscribeNext { (dat) -> Void in
                println(dat)
        }
        //MARK: 信号映射text 转为 NSNumber,  过滤number>3的信号  打印number
        self.passWord.rac_textSignal()
            .map { (dat) -> AnyObject! in
                return (dat as! NSString).length
            }.filter { (dat) -> Bool in
                self.passWord.backgroundColor = (dat as! NSNumber).integerValue > 3 ? UIColor.whiteColor() : UIColor.yellowColor()
                return (dat as! NSNumber).integerValue > 3
            }.subscribeNext { (dat) -> Void in
                println(dat)
        }
        //MARK: Login
        self.signIn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (dat) -> Void in
            let vc = AlbumViewController()
            vc.urlArray = [
                "http://e.hiphotos.baidu.com/image/pic/item/b2de9c82d158ccbfa0345b821bd8bc3eb03541fa.jpg",
                "http://h.hiphotos.baidu.com/image/pic/item/f11f3a292df5e0febe8bd3005e6034a85edf721b.jpg",
                "http://g.hiphotos.baidu.com/image/pic/item/e1fe9925bc315c60f2148de58fb1cb1349547733.jpg",
                "http://h.hiphotos.baidu.com/image/pic/item/962bd40735fae6cd9caa64690db30f2442a70f98.jpg"]
                self.delegate?.presentViewController(vc, animated: true) { () -> Void in
            }
        }
        //MARK: Register
        self.register.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (dat) -> Void in
            self.delegate?.navigationController?.pushViewController(UIViewController(), animated: true)
        }
        
        
        
        //定义信号变量
        var vaidNameSignal = self.userName.rac_textSignal().map { (dat) -> AnyObject! in
            return (dat as! String).isMobileNumber
        }
        let vaidPasswdSignal = self.passWord.rac_textSignal().map { (dat) -> AnyObject! in
            return count(dat as! String) > 4
        }
        //		var signUpSignal = RACSignal.combineLatest([vaidNameSignal,vaidPasswdSignal]).map { (dat) -> AnyObject! in
        //			return (self.vaidNameSignal as! Bool)
        //		}
        
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
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
}
