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
}
