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
    @IBOutlet weak var get: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func post(sender: AnyObject) {
        
        
        AFNetManager.instance.POST(ContentTypes.textHTML, url: url.text, parameter: json.text, success: { (task, obj) -> Void in
            self.log.text.append( "\r\n\r\n-------------------------\r\n \(task) \r\n\r\n \(obj)")
        }) { (task, error) -> Void in
            let alert = UIAlertView(title: "fail", message: "\(task) \r\n\r\n \(error)", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    @IBAction func get(sender: AnyObject) {
    }
}
