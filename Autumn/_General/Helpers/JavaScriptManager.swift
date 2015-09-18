//
//  JavaScriptManager.swift
//  summer
//
//  Created by Alex D. on 15/8/27.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import JavaScriptCore

class JavaScriptManager {
    
    static let instance = JavaScriptManager()
    private init() {
    }
    
    var context = JSContext()
    
    func runJS(jsSource:String,function:String,parameter:[AnyObject]) -> AnyObject {
        //出错处理
        context.exceptionHandler = { context, exception in
            print("JS Error: \(exception)")
        }
        //加载测试
        context.evaluateScript(jsSource)
        //运行 返回
        let factorial = context.objectForKeyedSubscript(function)
        return factorial.callWithArguments(parameter)
    }
    
    
}