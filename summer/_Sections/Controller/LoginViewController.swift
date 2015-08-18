//
//  LoginViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/18.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit

class LoginViewController: BaseNaviViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let v = (NSBundle.mainBundle().loadNibNamed("LoginView", owner: self, options: nil) as NSArray).lastObject as? LoginView {
            v.frame = self.view.frame
            self.view.addSubview(v)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
