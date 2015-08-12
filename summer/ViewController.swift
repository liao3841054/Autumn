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
        
        //MARK: GCD异步延时
        _ = GCDManager.delay(0.8, task: { () -> () in
            self.presentViewController(UINavigationController(rootViewController: LoginViewController()), animated: true, completion: { () -> Void in
                print("task start", appendNewline: false)
            })
        })
        //GCDManager.cancel(task)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

