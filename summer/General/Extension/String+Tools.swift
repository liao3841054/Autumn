//
//  String+Tools.swift
//  
//
//  Created by Ding Soung on 15/5/26.
//
//

extension String {
	//MARK: 转浮点数
	var floatValue: Float {
		return (self as NSString).floatValue
	}
	
	//MARK: MD5 加密  import <CommonCrypto/CommonCrypto.h>
	var md5: String! {
		let str = self.cStringUsingEncoding(NSUTF8StringEncoding)
		let strLen = CC_LONG(self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
		let digestLen = Int(CC_MD5_DIGEST_LENGTH)
		let result = UnsafeMutablePointer<CUnsignedChar>.alloc(digestLen)
		CC_MD5(str!, strLen, result)
		var hash = NSMutableString()
		for i in 0..<digestLen {
			hash.appendFormat("%02x", result[i])
		}
		result.dealloc(digestLen)
		return hash as String
	}
	
	func hexString() -> String {
		return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.hexString
	}
	func MD5() -> String {
		return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.MD5().hexString
	}
	func SHA1() -> String {
		return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.SHA1().hexString
	}
}
