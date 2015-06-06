//
//  AlbumImageView.swift
//  summer
//
//  Created by Ding Soung on 15/6/5.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit







class AlbumImageView: UIView, UIScrollViewDelegate {
	
	var img: UIImageView!
	private var scrollView:UIScrollView!
	private var containerView:UIView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.img = UIImageView(frame: frame)
		self.img.backgroundColor = UIColor(white: 0, alpha: 0.5)
		self.img.clipsToBounds = true
		self.img.contentMode = UIViewContentMode.ScaleAspectFit
		
		self.scrollView = UIScrollView(frame: self.bounds)
		self.scrollView.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
		self.scrollView.showsHorizontalScrollIndicator = false
		self.scrollView.showsVerticalScrollIndicator = false
		self.scrollView.delegate = self
		self.scrollView.bounces = false
		
		self.containerView = UIView(frame: self.bounds)
		
		self.containerView.addSubview(self.img)
		self.scrollView.addSubview(self.containerView)
		self.addSubview(self.scrollView)
		
		var doubleTapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
		doubleTapGesture.numberOfTapsRequired = 2
		self.containerView.addGestureRecognizer(doubleTapGesture)
		var tapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
		tapGesture.numberOfTapsRequired = 1
		self.containerView.addGestureRecognizer(tapGesture)
		tapGesture.requireGestureRecognizerToFail(doubleTapGesture) //双击失败后执行单击
		
		//init process
		
		self.scrollView.maximumZoomScale = 5.0
		self.scrollView.minimumZoomScale = 1.0
		self.scrollView.zoomScale = 2.0
	}
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
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
	
	
	
	func getImgWithFactor() -> CGFloat {
		return self.bounds.size.width / self.img.image!.size.width
	}
	func getImgHeightFactor() -> CGFloat {
		return self.bounds.size.height / self.img.image!.size.height
	}
	func newSizeByoriginalSize(oldSize:CGSize, maxSize:CGSize) -> CGSize {
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
	func resetViewFrame(newFrame:CGRect) {
		self.frame = newFrame
		self.scrollView.frame = self.bounds
		self.containerView.frame = self.bounds
		
		var vsize = self.frame.size
		//process
	}
	
	func tapAction(tap:UITapGestureRecognizer) {
		if(tap.numberOfTapsRequired == 2) {
			if (self.scrollView.minimumZoomScale <= self.scrollView.zoomScale && self.scrollView.maximumZoomScale > self.scrollView.zoomScale) {
				self.scrollView.setZoomScale(self.scrollView.maximumZoomScale, animated: true)
			}else {
				self.scrollView.setZoomScale(self.scrollView.minimumZoomScale, animated: true)
			}
		} else if(tap.numberOfTapsRequired == 1) {
			//单击 退出View
		}
	}

}






/*
#import "ZoomImgItem.h"
@implementation ZoomImgItem

- (void)dealloc {
	self.imgName = nil;
	if (imageView) {
		[imageView release];
		imageView = nil;
	}
	[super dealloc];
	}
	- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		[self _initView];
	}
	return self;
	}

	- (void)awakeFromNib
		{
			// Initialization code
		}


		- (void)_initView {
			self.selectionStyle = UITableViewCellSelectionStyleNone;

			imageView = [[KL_ImageZoomView alloc] initWithFrame:CGRectZero];
			[self.contentView addSubview:imageView];
			}

			- (void)setImgName:(NSString *)imgName {
    if (_imgName != imgName) {
		[_imgName release];
		_imgName = [imgName retain];
    }
    [imageView resetViewFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
    [imageView uddateImageWithUrl:imgName];
				}
				
				
				- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

@end
*/


/*
class AlbumImageView: UIImageView {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.contentMode = UIViewContentMode.ScaleAspectFit
		
		var pin:UIPinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: Selector("handlePinchGesture:"))
		self.addGestureRecognizer(pin)
		
		var tg1:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
		var tg2:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("handleTapGesture:"))
		tg1.numberOfTapsRequired = 1
		tg1.requireGestureRecognizerToFail(tg2)		//这里保证双击的时候不会出发单击时间
		tg2.numberOfTapsRequired = 2
		self.userInteractionEnabled = true
		self.addGestureRecognizer(tg1)
		self.addGestureRecognizer(tg2)
	}
	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	//捏
	func handlePinchGesture(sender:UIGestureRecognizer){
		var factor:CGFloat = (sender as! UIPinchGestureRecognizer).scale
		sender.view!.transform = CGAffineTransformMakeScale(factor, factor)
	}
	
	/*
	单击self消失
	双击self.imageView放大和缩小
	*/
	func handleTapGesture(sender:UITapGestureRecognizer){
		let touchCount:Int = sender.numberOfTapsRequired
		switch touchCount {
		case 1:
			UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
				}, completion: {(value:Bool) in
					self.removeFromSuperview()
			})
		case 2:
			self.handleDoubleClick(sender)
		default:println("")
		}
	}
	func handleDoubleClick(sender:UIGestureRecognizer){
		//.ScaleAspectFit是原比例
		if sender.view!.contentMode == UIViewContentMode.ScaleAspectFit {
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				sender.view!.contentMode = UIViewContentMode.Center
			})
		}else{
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				sender.view!.contentMode = UIViewContentMode.ScaleAspectFit
			})
		}
	}
	
	

}
*/