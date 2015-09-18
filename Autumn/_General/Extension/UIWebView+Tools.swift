//
//  UIWebView+Tools.swift
//  summer
//
//  Created by Alex D. on 15/8/27.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import JavaScriptCore

extension UIWebView {
    
    func setJS(forkey:String, block : @convention(block) (NSString!) -> Void) {
        if let context = self.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext {
            context.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: forkey)
        }
    }
    
}



