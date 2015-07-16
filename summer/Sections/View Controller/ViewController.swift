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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		print(ShareData.instance.index)
		
		//MARK: GCD异步延时
		var task = GCDManager.delay(2, task: { () -> () in
			print("task start", appendNewline: false)
		})
		//GCDManager.cancel(task)
		
		//MARK: 设置阴影
		var view = UIButton(frame: CGRectMake(40, 40, 50, 50))
		view.backgroundColor = UIColor.greenColor()
		view.setShadow(UIColor.yellowColor().CGColor, offset: CGSizeMake(5, 5), opacity: 0.5, radius: 10)
		self.view.addSubview(view)
		
		//MARK: 全屏显示
		view.viewInFullScreen()
		
		
		
		
		//MARK:ReactiveCocoa
		//过滤 text长度大于3时的信号 打印dat
		self.name.rac_textSignal().filter { (dat) -> Bool in
			return (dat as! NSString).length > 3
			}.subscribeNext { (dat) -> Void in
				print(dat)
		}
		//信号映射text 转为 NSNumber,  过滤number>3的信号  打印number
		self.pwssword.rac_textSignal()
			.map { (dat) -> AnyObject! in
				return (dat as! NSString).length
			}.filter { (dat) -> Bool in
				return (dat as! NSNumber).integerValue > 3
			}.subscribeNext { (dat) -> Void in
				print(dat)
		}
		self.sigIn.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext { (dat) -> Void in
			print("button clinked")
		}
		//定义信号变量
		var vaidNameSignal = self.name.rac_textSignal().map { (dat) -> AnyObject! in
			return (dat as! String).isMobileNumber
		}
		var vaidPasswdSignal = self.pwssword.rac_textSignal().map { (dat) -> AnyObject! in
			return (dat as! String).characters.count > 4
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
		
		
		//MARK: 本地推送消息
		NotificationManager.instance.scheduleNotification(123, delaySeconds: 3, timeZone: NSTimeZone.defaultTimeZone(), message: "本地消息")
		//cancelNotification(123);
		
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
	
	private func updateUIState() {
		self.sigIn.enabled = self.nameIsValid && self.passwordISValid
	}
	func nameChanged(sendr:AnyObject){
		self.nameIsValid = self.name.text!.characters.count > 3
		self.updateUIState()
	}
	func passwdChanged(sendr:AnyObject) {
		self.passwordISValid = self.pwssword.text!.characters.count > 3
		self.updateUIState()
	}
	
	@IBAction func albumButtonAction(sender: AnyObject) {
		let vc = AlbumViewController()
		vc.urlArray = [
			"http://e.hiphotos.baidu.com/image/pic/item/b2de9c82d158ccbfa0345b821bd8bc3eb03541fa.jpg",
			"http://h.hiphotos.baidu.com/image/pic/item/f11f3a292df5e0febe8bd3005e6034a85edf721b.jpg",
			"http://g.hiphotos.baidu.com/image/pic/item/e1fe9925bc315c60f2148de58fb1cb1349547733.jpg",
			"http://h.hiphotos.baidu.com/image/pic/item/962bd40735fae6cd9caa64690db30f2442a70f98.jpg"]
		self.presentViewController(vc, animated: true) { () -> Void in
		}
	}
	

	
	
	
	
	
	
}

