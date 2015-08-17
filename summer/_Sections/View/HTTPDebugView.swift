//
//  HTTPDebugView.swift
//  summer
//
//  Created by Alex D. on 15/8/17.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit

class HTTPDebugView: UIView {
   
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var json: UITextView!
    
    @IBOutlet weak var post: UIButton!
    @IBOutlet weak var get: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func post(sender: AnyObject) {
        AFNetManager.instance.POST(url.text, parameter: json.text, success: { (opt, obj) -> Void in
            let alert = UIAlertView(title: "success", message: "\(opt) \r\n\r\n \(obj)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }) { (opt, error) -> Void in
            let alert = UIAlertView(title: "fail", message: "\(opt) \r\n\r\n \(error)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    @IBAction func get(sender: AnyObject) {
        AFNetManager.instance.GET(url.text, parameter: nil, success: { (opt, obj) -> Void in
            let alert = UIAlertView(title: "success", message: "\(opt) \r\n\r\n \(obj)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }) { (opt, error) -> Void in
            let alert = UIAlertView(title: "fail", message: "\(opt) \r\n\r\n \(error)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    
}
