//
//  ViewController.swift
//  summer
//
//  Created by Ding Soung on 15/5/25.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ShareData.instance.index)
        
        //MARK: GCD异步延时
        _ = GCDManager.delay(2, task: { () -> () in
            self.presentViewController(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: { () -> Void in
                print("task start", appendNewline: false)
            })
        })
        //GCDManager.cancel(task)
        
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
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    
    
    
    
    
    
}

