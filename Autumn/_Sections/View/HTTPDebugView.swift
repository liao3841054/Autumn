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
    @IBOutlet weak var log: UITextView!
    
    @IBOutlet weak var post: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func post(sender: AnyObject) {
        
        NetManager.instance.autoRequest(url.text!, parameter: json.text, type: ContentTypes.textHTML, success: { (tsk, data) -> Void in
            self.log.text = "\r\n-------------------------\r\n \(tsk) \r\n\r\n \(data)"
        }) { (tsk, error) -> Void in
            let alert = UIAlertView(title: "fail", message: "\(tsk) \r\n\r\n \(error)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    @IBAction func get(sender: AnyObject) {
    }
}
