//
//  LoginViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit

class LoginViewController: BaseNaviViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let v = (NSBundle.mainBundle().loadNibNamed("LoginView", owner: self, options: nil) as NSArray).lastObject as? LoginView {
            v.frame = self.view.frame
            v.delegate = self
            self.view.addSubview(v)
        }
    }
}
