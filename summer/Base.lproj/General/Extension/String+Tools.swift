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
	//MARK: 由NSString扩展而来
	var hexString: String {
		return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.hexString
	}
	var MD5: String {
		return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.MD5().hexString
	}
	var SHA1: String {
		return (self as NSString).dataUsingEncoding(NSUTF8StringEncoding)!.SHA1().hexString
	}
	
	//MARK: 是否为手机号
	var isMobileNumber: Bool {
		//前缀0 86 17951 或者没有  中间13* 15* 17* 145 147 后加8个0～9的数
		var format = NSPredicate(format: "SELF MATCHES %@", "^(0|86|086|17951)?1(3[0-9]|4[57]|7[0-9]|8[0123456789])[0-9]{8}$")
		return format.evaluateWithObject(self)
	}
}
