//
//  AlbumImageView.swift
//  summer
//
//  Created by Ding Soung on 15/6/5.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class AlbumImageView: UIImageView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.contentMode = UIViewContentMode.ScaleAspectFit
		
		var pin:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("handlePinchGesture:"))
		self.addGestureRecognizer(pin)
		
		var tg1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
		var tg2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
		tg1.numberOfTapsRequired = 1
		tg1.requireGestureRecognizerToFail(tg2)		//这里保证双击的时候不会出发单击时间
		tg2.numberOfTapsRequired = 2
		self.userInteractionEnabled = true
		self.addGestureRecognizer(tg1)
		self.addGestureRecognizer(tg2)
	}
	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	//捏
	func handlePinchGesture(sender:UIGestureRecognizer){
		var factor:CGFloat = (sender as! UIPinchGestureRecognizer).scale
		sender.view!.transform = CGAffineTransformMakeScale(factor, factor)
	}
	
	/*
	单击self消失
	双击self.imageView放大和缩小
	*/
	func handleTapGesture(sender:UITapGestureRecognizer){
		let touchCount:Int = sender.numberOfTapsRequired
		switch touchCount {
		case 1:
			UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
				}, completion: {(value:Bool) in
					self.removeFromSuperview()
			})
		case 2:
			self.handleDoubleClick(sender)
		default:println("")
		}
	}
	func handleDoubleClick(sender:UIGestureRecognizer){
		//.ScaleAspectFit是原比例
		if sender.view!.contentMode == UIViewContentMode.ScaleAspectFit {
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				sender.view!.contentMode = UIViewContentMode.Center
			})
		}else{
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				sender.view!.contentMode = UIViewContentMode.ScaleAspectFit
			})
		}
	}
	
	

}
