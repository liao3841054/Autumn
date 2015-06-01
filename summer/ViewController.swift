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
		self.name.rac_textSignal().filter { (dat) -> Bool in
			return (dat as! NSString).length > 3
			}.subscribeNext { (dat) -> Void in
				println(dat)
		}
		self.pwssword.rac_textSignal()
			.map { (dat) -> AnyObject! in
				return (dat as! NSString).length
			}.filter { (dat) -> Bool in
				return (dat as! NSNumber).integerValue > 3
			}.subscribeNext { (dat) -> Void in
				println(dat)
		}
		self.sigIn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (dat) -> Void in
			println("button clinked")
		}
		
		var vaidNameSignal = self.name.rac_textSignal().map { (dat) -> AnyObject! in
			return count(dat as! String) > 3
		}
		var vaidPasswdSignal = self.pwssword.rac_textSignal().map { (dat) -> AnyObject! in
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
					self.name.backgroundColor = (dat as! UIColor)
			}
		#endif
		vaidPasswdSignal.map { (dat) -> AnyObject! in
			return (dat as! Bool) ? UIColor.clearColor() : UIColor.yellowColor()
			}.subscribeNext { (dat) -> Void in
				self.pwssword.backgroundColor = (dat as! UIColor)
		}
		
		
		
		
		//发送通知消息
		scheduleNotification(12345);
		//取消通知消息
		//cancelNotification(12345);
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	
	private func updateUIState() {
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
	
	
	
	//发送通知消息
	private func scheduleNotification(itemID:Int){
		//如果已存在该通知消息，则先取消
		cancelNotification(itemID)
		//创建UILocalNotification来进行本地消息通知
		var localNotification = UILocalNotification()
		//推送时间（设置为30秒以后）
		localNotification.fireDate = NSDate(timeIntervalSinceNow: 5)
		//时区
		localNotification.timeZone = NSTimeZone.defaultTimeZone()
		//推送内容
		localNotification.alertBody = "来自hangge.com的本地消息"
		//声音
		localNotification.soundName = UILocalNotificationDefaultSoundName
		//额外信息
		localNotification.userInfo = ["ItemID":itemID]
		UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
	}
	//取消通知消息
	private func cancelNotification(itemID:Int){
		//通过itemID获取已有的消息推送，然后删除掉，以便重新判断
		let existingNotification = self.notificationForThisItem(itemID) as UILocalNotification?
		if existingNotification != nil {
			//如果existingNotification不为nil，就取消消息推送
			UIApplication.sharedApplication().cancelLocalNotification(existingNotification!)
		}
	}
	//通过遍历所有消息推送，通过itemid的对比，返回UIlocalNotification
	private func notificationForThisItem(itemID:Int)-> UILocalNotification? {
		let allNotifications = UIApplication.sharedApplication().scheduledLocalNotifications
		for notification in allNotifications {
			var info:Dictionary<String,Int>? = notification.userInfo as? Dictionary
			var number = info?["ItemID"]
			if number != nil && number == itemID {
				return notification as? UILocalNotification
			}
		}
		return nil
	}
	
	
	
	
	
	
}

