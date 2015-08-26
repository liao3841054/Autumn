//
//  WebView.swift
//  summer
//
//  Created by Alex D. on 15/8/21.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit
import JavaScriptCore

class WebView: UIWebView {
    
    
    
    
    
    
    
    JSContext * context = [web valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"btnClicked"] = ^(){
    
    NSLog(@"=======start=========");
    
    NSArray * args = [JSContext currentArguments];
    for (JSValue * value in args) {
    NSLog(@"args传递过来的值是%@",value);
    }
    JSValue * jv = args[0];
    TViewController * tv = [[TViewController alloc] init];
    tv.str = jv.toString;
    [self.navigationController pushViewController:tv animated:YES];
    NSLog(@"========end===========");
    
    
    };
    
    
    
    func setJS( ) {
        if let context = self.valueForKeyPath("documentView.webView.mainFrame.javaScriptContext") as? JSContext {
            

            var block : @objc_block (NSString!) -> Void = {
                (string : NSString!) -> Void in
                
                let alert = UIAlertView(title: "", message: "hhbhsdbhsbd", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
            context.setObject(unsafeBitCast(block, AnyObject.self), forKeyedSubscript: "test")
        }
        
        
        
        
    }
    
    func runJS(name:String,type:String,function:String,arguments:[AnyObject]) {
        if let path = NSBundle.mainBundle().pathForResource("test", ofType: "js") {
            var jsSource = NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil) as! String
            //let jsSource: String! = String.stringWithContentsOfFile(NSHomeDirectory()+"/mylib.js")
            
            var context = JSContext()
            //出错处理
            context.exceptionHandler = { context, exception in
                println("JS Error: \(exception)")
            }
            //执行
            context.evaluateScript(jsSource)
            
            let factorial = context.objectForKeyedSubscript("factorial")
            println(factorial.callWithArguments([10]))
            
            let helloFunc = context.objectForKeyedSubscript("hello")
            println(helloFunc.callWithArguments(["World!!!"]))
            
            let holaFunc = context.objectForKeyedSubscript("hola")
            println(holaFunc.callWithArguments(["Bobby"]))
        }
    }
}
