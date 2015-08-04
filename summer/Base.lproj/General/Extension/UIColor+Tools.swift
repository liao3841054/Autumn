//
//  UIColor+Tools.swift
//  summer
//
//  Created by Alex D. on 15/7/4.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//


extension UIColor {
    //MARK: UIColor for Hex number
    public func hexInt(FFFFFFFF:Int) -> UIColor {
        let r = FFFFFFFF >> 24
        let g = (FFFFFFFF >> 16) & 0xFF
        let b = (FFFFFFFF >> 8) & 0xFF
        let a = (FFFFFFFF >> 8) & 0xFF
        return UIColor(red: CGFloat(r) * 0.00390625, green: CGFloat(g) * 0.00390625, blue: CGFloat(b) * 0.00390625, alpha: CGFloat(a) * 0.00390625)
    }
    public func hexStr(FFFFFFFF:String) -> UIColor {
        if FFFFFFFF.characters.count == 8 {
            _ = "0x" + FFFFFFFF
        }
        if FFFFFFFF.characters.count == 10 {
            if let ffffffff = Int(FFFFFFFF) {
                return hexInt(ffffffff)
            } else {
                assert(false, "string value error")
            }
        }
        return UIColor.clearColor()
    }
}