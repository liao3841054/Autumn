//
//  AlbumImageView.swift
//  summer
//
//  Created by Ding Soung on 15/6/5.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

protocol AlbumImageViewDelegate {
	func albumImageViewSignalTaped()
}
class AlbumImageView: UITableViewCell, UIScrollViewDelegate {
	
	var img: UIImageView!
	var delegate:AlbumImageViewDelegate?
	private var scrollView:UIScrollView!
	private var containerView:UIView!
	
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        self.backgroundColor = UIColor.clearColor()
        
        self.scrollView = UIScrollView(frame: self.bounds)
        self.scrollView.backgroundColor = UIColor.clearColor()
        self.scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.maximumZoomScale = 5.0
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.zoomScale = 1.0
        self.addSubview(self.scrollView)
        
        self.containerView = UIView(frame: self.bounds)
        self.containerView.backgroundColor = UIColor.clearColor()
        self.scrollView.addSubview(self.containerView)
        
        self.img = UIImageView(frame: frame)
        self.img.backgroundColor = UIColor.clearColor()
        self.img.clipsToBounds = true
        self.img.contentMode = UIViewContentMode.ScaleAspectFit
        self.containerView.addSubview(self.img)
        
        var doubleTapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
        doubleTapGesture.numberOfTapsRequired = 2
        self.containerView.addGestureRecognizer(doubleTapGesture)
        var tapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
        tapGesture.numberOfTapsRequired = 1
        self.containerView.addGestureRecognizer(tapGesture)
        tapGesture.requireGestureRecognizerToFail(doubleTapGesture) //双击失败后执行单击
        
        //init process
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
	
	//MARK: ScrollView delegate
	func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
		return self.containerView
	}
	func scrollViewDidZoom(scrollView: UIScrollView) {
		var Ws = self.scrollView.frame.size.width - self.scrollView.contentInset.left - self.scrollView.contentInset.right
		var Hs = self.scrollView.frame.size.height - self.scrollView.contentInset.top - self.scrollView.contentInset.bottom
		var W = self.containerView.frame.size.width
		var H = self.containerView.frame.size.height
		var rct = self.containerView.frame
		rct.origin.x = max((Ws - W) * 0.5, 0)
		rct.origin.y = max((Hs - H) * 0.5, 0)
		self.containerView.frame = rct
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
			self.delegate?.albumImageViewSignalTaped()
		}
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
			var newHeight = oldSize.height * bs
			newSize = CGSizeMake(maxSize.width, newHeight)
			
			if(newHeight > maxSize.height) {
				bs = self.getImgHeightFactor()
				var newWidth = oldSize.width * bs
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
		
		var vsize = self.frame.size
		//process
	}
}