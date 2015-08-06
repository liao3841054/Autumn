//
//  AlbumImageView.swift
//  summer
//
//  Created by Ding Soung on 15/6/5.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

class AlbumImageCell: UITableViewCell, UIScrollViewDelegate {
    
    var imageUrl:String? {
        set {
            if let value = newValue {
                self.img.sd_setImageWithURL(NSURL(string: value), placeholderImage: nil)
            }
        }
        get {
            return nil
        }
    }
    var delegate:AlbumViewController?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.yellowColor()
        self.contentView.backgroundColor = UIColor.redColor()
        
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.maximumZoomScale = 5.0
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.zoomScale = 1.0
        
        self.img.frame = self.scrollView.frame
        self.img.backgroundColor = UIColor.clearColor()
        self.img.clipsToBounds = true
        self.img.contentMode = UIViewContentMode.ScaleAspectFit
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
        doubleTapGesture.numberOfTapsRequired = 2
        self.scrollView.addGestureRecognizer(doubleTapGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
        tapGesture.numberOfTapsRequired = 1
        self.scrollView.addGestureRecognizer(tapGesture)
        tapGesture.requireGestureRecognizerToFail(doubleTapGesture) //双击失败后执行单击
    }
    
    //MARK: ScrollView delegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.img
    }
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let Ws = self.scrollView.frame.size.width - self.scrollView.contentInset.left - self.scrollView.contentInset.right
        let Hs = self.scrollView.frame.size.height - self.scrollView.contentInset.top - self.scrollView.contentInset.bottom
        let W = self.img.frame.size.width
        let H = self.img.frame.size.height
        var rct = self.img.frame
        rct.origin.x = max((Ws - W) * 0.5, 0)
        rct.origin.y = max((Hs - H) * 0.5, 0)
        self.img.frame = rct
    }
    
    //MARK: tapgestuew action
    func tapAction(tap:UITapGestureRecognizer) {
        if(tap.numberOfTapsRequired == 2) {
            if (self.scrollView.minimumZoomScale <= self.scrollView.zoomScale && self.scrollView.maximumZoomScale > self.scrollView.zoomScale) {
                self.scrollView.setZoomScale(self.scrollView.maximumZoomScale, animated: true)
            }else {
                self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
            }
        } else if(tap.numberOfTapsRequired == 1) {
            self.delegate?.dismissViewControllerAnimated(true, completion: { () -> Void in
            })
        }
    }
    
    #if false
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
    }
    
    private	func getImgWithFactor() -> CGFloat {
        return self.bounds.size.width / self.img.image!.size.width
    }
    private	func getImgHeightFactor() -> CGFloat {
        return self.bounds.size.height / self.img.image!.size.height
    }
    private	func newSizeByoriginalSize(oldSize:CGSize, maxSize:CGSize) -> CGSize {
        if(oldSize.width <= 0 || oldSize.height <= 0) {
            return CGSizeZero
        }
        var newSize = CGSizeZero
        if(oldSize.width > maxSize.width ||  oldSize.height > maxSize.height) {
            var bs = self.getImgWithFactor()
            let newHeight = oldSize.height * bs
            newSize = CGSizeMake(maxSize.width, newHeight)
            
            if(newHeight > maxSize.height) {
                bs = self.getImgHeightFactor()
                let newWidth = oldSize.width * bs
                newSize = CGSizeMake(newWidth, maxSize.height)
            }
        } else {
            newSize = oldSize
        }
        return newSize
    }
    private	func resetViewFrame(newFrame:CGRect) {
        self.frame = newFrame
        self.scrollView.frame = self.bounds
        self.containerView.frame = self.bounds
        
        _ = self.frame.size
        //process
    }
    #endif
}
