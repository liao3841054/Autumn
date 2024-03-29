//
//  BaseViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: "viewTapGesture:")
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        self.view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "viewPanGesture:"))
        self.tabBarController?.tabBar.hidden = true
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let pageName = self.title {
            MobClick.beginLogPageView(pageName)
        } else {
            MobClick.beginLogPageView(NSStringFromClass(object_getClass(self)))
        }
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let pageName = self.title {
            MobClick.endLogPageView(pageName)
        } else {
            MobClick.endLogPageView(NSStringFromClass(object_getClass(self)))
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewTapGesture(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    func viewPanGesture(sender:UIPanGestureRecognizer) {
        self.view.endEditing(true)
    }
}
