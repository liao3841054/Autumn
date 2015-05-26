//
//  ViewController.swift
//  summer
//
//  Created by Ding Soung on 15/5/25.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		println(ShareData.instance.index)
		
		var task = GCDManager.delay(2, task: { () -> () in
			print("task start")
		})
		//GCDManager.cancel(task)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

