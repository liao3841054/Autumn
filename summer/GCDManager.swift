//
//  GCDManager.swift
//  summer
//
//  Created by Ding Soung on 15/5/26.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import Foundation

class GCDManager: NSObject {
	
	typealias Task = (cancel : Bool) -> ()
	class func delay(time:NSTimeInterval, task:()->()) ->  Task? {
		
		func dispatch_later(block:()->()) {
			dispatch_after(
				dispatch_time(
					DISPATCH_TIME_NOW,
					Int64(time * Double(NSEC_PER_SEC))),
				dispatch_get_main_queue(),
				block)
		}
		
		var closure: dispatch_block_t? = task
		var result: Task?
		
		let delayedClosure: Task = {
			cancel in
			if let internalClosure = closure {
				if (cancel == false) {
					dispatch_async(dispatch_get_main_queue(), internalClosure);
				}
			}
			closure = nil
			result = nil
		}
		
		result = delayedClosure
		
		dispatch_later {
			if let delayedClosure = result {
				delayedClosure(cancel: false)
			}
		}
		
		return result;
	}
	
	class func cancel(task:Task?) {
		task?(cancel: true)
	}
}

