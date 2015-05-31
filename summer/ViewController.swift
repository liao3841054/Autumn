//
//  ViewController.swift
//  summer
//
//  Created by Ding Soung on 15/5/25.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var pwssword: UITextField!
	@IBOutlet weak var sigIn: UIButton!
	private var nameIsValid = false
	private var passwordISValid = false
	private var sigInService: SignInService!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		println(ShareData.instance.index)
		
		//MARK: GCD异步延时
		var task = GCDManager.delay(2, task: { () -> () in
			print("task start")
		})
		//GCDManager.cancel(task)
		
		//MARK: 设置阴影
		var view = UIButton(frame: CGRectMake(40, 40, 50, 50))
		view.backgroundColor = UIColor.greenColor()
		view.setShadow(color: UIColor.yellowColor().CGColor, offset: CGSizeMake(5, 5), opacity: 0.5, radius: 10)
		self.view.addSubview(view)
		
		//MARK:ReactiveCocoa
		self.updateUIState()
		self.sigInService = SignInService()
		self.name.addTarget(self, action: "nameChanged:", forControlEvents: UIControlEvents.EditingChanged)
		self.pwssword.addTarget(self, action: "passwdChanged:", forControlEvents: UIControlEvents.EditingChanged)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	private func updateUIState() {
		self.name.backgroundColor = self.nameIsValid ? UIColor.clearColor() : UIColor.yellowColor()
		self.pwssword.backgroundColor = self.passwordISValid ? UIColor.clearColor() : UIColor.yellowColor()
		self.sigIn.enabled = self.nameIsValid && self.passwordISValid
	}
	func nameChanged(sendr:AnyObject){
		self.nameIsValid = count(self.name.text) > 3
		self.updateUIState()
	}
	func passwdChanged(sendr:AnyObject) {
		self.passwordISValid = count(self.pwssword.text) > 3
		self.updateUIState()
	}


}

