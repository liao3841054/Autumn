//
//  ViewController.swift
//  Autumn
//
//  Created by Alex D. on 15/9/18.
//  Copyright © 2015年 Alex D. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //MARK: GCD异步延时
        _ = GCDManager.delay(0.8, task: { () -> () in
            
            let vc = UIStoryboard(name: "Summer", bundle: nil).instantiateViewControllerWithIdentifier("My") as! MyViewController
            self.presentViewController(vc, animated: true, completion: nil)
        })
        //GCDManager.cancel(task)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

