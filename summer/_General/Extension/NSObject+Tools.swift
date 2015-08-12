//
//  NSObjec+Tools.swift
//  summer
//
//  Created by Alex D. on 15/8/12.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

extension NSObject {
    
    //MARK: 闭包实现 C中的代码块功能
    func closure(mark:String? = "",
        run:Bool? = true,
        block:()->Void,
        complete:(()->Void)? = {()->Void in
            println("执行完毕")
        }) {
        if run != true { return }
        block()
        complete?()
    }
    func closure(block:()->Void) {
        self.closure(block: block, complete: nil)
    }
}
