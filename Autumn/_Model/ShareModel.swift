//
//  ShareModel.swift
//  summer
//
//  Created by Alex D. on 15/8/13.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

//MARK: 最简Swift 单例写法
class ShareModel: NSObject {
    static let instance = ShareModel()
    
    
    var index:String!
    
    private override init() {
        index = "hello shareModel"
    }
    
    func function(){
        print(index)
    }
}