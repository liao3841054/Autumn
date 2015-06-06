//
//  UIVIew+Tools.swift
//  summer
//
//  Created by Ding Soung on 15/5/27.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

extension UIView {
	//MARK: 设置阴影
	func setShadow(color:CGColor? = UIColor.darkGrayColor().CGColor, offset:CGSize? = CGSizeMake(2, 3), opacity:Float? = 0.5, radius:CGFloat? = 3) {
		if let v = color { self.layer.shadowColor = v }
		if let v = offset { self.layer.shadowOffset = v }
		if let v = opacity { self.layer.shadowOpacity = v }
		if let v = radius { self.layer.shadowRadius = v }
	}
	//MARK: 兼容Objective－C
	func setShadow(color:CGColor, offset:CGSize, opacity:Float, radius:CGFloat) {
		self.setShadow(color: color, offset: offset, opacity: opacity, radius: radius)
	}
	
	
	func addFullScreemView(delegate:UIViewController) {
		var tapGesture = UITapGestureRecognizer(target: delegate, action: "fullScreemView:")
		tapGesture.numberOfTapsRequired = 1
		self.addGestureRecognizer(tapGesture)
	}
	func fullScreemView(sender: UITapGestureRecognizer) {
	}
	
	
	func viewInFullScreen(target:UIViewController) {
		//var fullView = self
		//target.view.addSubview(fullView)
		UIView.animateWithDuration(0.3, animations: { () -> Void in
			self.frame = target.view.frame
			self.backgroundColor = UIColor.grayColor()
			self.alpha = 1
		})
		var tapGesture = UITapGestureRecognizer(target: self, action: "fullViewTapGesture:")
		tapGesture.numberOfTapsRequired = 1
		self.addGestureRecognizer(tapGesture)
	}
	func fullViewTapGesture(sender:UIPanGestureRecognizer) {
		UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
			}, completion: {(value:Bool) in
				self.removeFromSuperview()
		})
	}
}

