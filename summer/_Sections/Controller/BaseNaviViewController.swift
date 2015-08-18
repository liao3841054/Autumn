//
//  BaseViewController.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit
import ReactiveCocoa

class BaseNaviViewController: BaseViewController {
    
    var srcVC:UIViewController?
    var leftBlock:(() -> Void)?
    var rightBlock:(() -> Void)?
    var underNavi = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.translucent = underNavi
        if(self.navigationController?.navigationBar.translucent == true) {
            if let v = self.navigationController?.navigationBar.frame.height {
                self.view.frame.origin.y =  v + 20
            }
        } else if(self.navigationController?.navigationBar.translucent == false){
            if let v = self.navigationController?.navigationBar.frame.height {
                self.view.frame.size.height -= (v + 20)
            }
        }
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "leftBarButtonAction")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: "rightBarButtonAction")
        if self.rightBlock == nil {
            self.leftBlock = { () -> Void in
                if self.navigationController == nil {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }else{
                    
                    NSArray *viewControllers = self.navigationController.viewControllers;
                    UIViewController *rootViewController = (UIViewController *)[viewControllers objectAtIndex:viewControllers.count - 2];
                    
                    
                    self.navigationController?.viewControllers.count
                    
                    if let v = self.srcVC {
                        self.navigationController?.popToViewController(v, animated: true)
                    }else{
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                }
            }
        }
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = false
    }
    func leftBarButtonAction(){
        self.leftBlock?()
    }
    func rightBarButtonAction(){
        self.rightBlock?()
    }
}


