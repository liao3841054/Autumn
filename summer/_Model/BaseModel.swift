//
//  BaseModel.swift
//  summer
//
//  Created by Ding Soung on 15/5/25.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
	
    #if false
    //MARK: JSON转model
	init(JSONString: String) {
		super.init()
		var error : NSError?
		let JSONData = JSONString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
		let JSONDictionary = NSJSONSerialization.JSONObjectWithData(JSONData!, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
		
		for (key, value) in JSONDictionary {
			let keyName = key as! String
			let keyValue: String = value as! String
			if (self.respondsToSelector(NSSelectorFromString(keyName))) {
				self.setValue(keyValue, forKey: keyName)
			}
		}
	}
    #endif
	
	//MARK: 字典转model
	init(JSONDic : [String : AnyObject]) {
		super.init()
        self.setValuesForKeysWithDictionary(JSONDic)
	}
	
	//MARK: 字典转array
	class func modelWithArray(dictArray:[NSDictionary]) -> NSArray {
		let array: NSMutableArray = []
		for dic in dictArray {
			let model = self.new()
			model.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
			array.addObject(model)
		}
		return array
	}
	
	override func setValue(value: AnyObject!, forUndefinedKey key: String) {
		print("未定义的key:\(key) for value:\(value)")
	}
}