//
//  AlbumViewController.swift
//  GiftBox
//
//  Created by Ding Soung on 15/6/5.
//  Copyright (c) 2015年 xinyihezi. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UIScrollViewDelegate {
	
	var urlArray:[String] = []
	var index:CGFloat = 0
	
	private var scrollView: UIScrollView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		NSNotificationCenter.defaultCenter().addObserver(self, selector: "networkStatusChanged", name: "networkStatusChanged", object: nil)
		
		self.view.backgroundColor = UIColor.blackColor()
		
		self.scrollView = UIScrollView(frame: self.view.frame)
		self.scrollView.contentSize = self.scrollView.frame.size
		self.scrollView.delegate = self
		self.scrollView.pagingEnabled = true
		self.scrollView.bounces = true
		self.scrollView.showsHorizontalScrollIndicator = false
		self.scrollView.showsVerticalScrollIndicator = false
		self.scrollView.backgroundColor = UIColor.clearColor()
		self.view.addSubview(scrollView)
		
		
//		var tapGesture = UITapGestureRecognizer(target: self, action: "viewTapGesture:")
//		tapGesture.numberOfTapsRequired = 1
//		self.scrollView.addGestureRecognizer(tapGesture)
//		self.scrollView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: "viewPanGesture:"))
		
	}
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		self.navigationController?.navigationBarHidden = true
		self.tabBarController?.tabBar.hidden = true
		
		self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * CGFloat(self.urlArray.count), self.scrollView.frame.size.width)
		for var index = 0; index < self.urlArray.count; index += 1 {
			var view = AlbumImageView(frame: self.view.frame)
			view.frame.origin.x = self.view.frame.size.width * CGFloat(index)
			view.sd_setImageWithURL(NSURL(string: self.urlArray[index]), placeholderImage: UIImage(named: ""))
			scrollView.addSubview(view)
		}
		UIView.animateWithDuration(0.3, animations: { () -> Void in
			self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.index, 0)
		})
	}
	override func viewWillDisappear(animated: Bool) {
		super.viewWillDisappear(animated)
	}
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		if(scrollView == self.scrollView) {
			//self.segment.selectedSegmentIndex = Int(scrollView.contentOffset.x / self.view.frame.width)
		}
	}
	
	
	

	
	
	func viewTapGesture(sender: UITapGestureRecognizer) {
		self.dissmissThisView()
	}
	func viewPanGesture(sender:UIPanGestureRecognizer) {
		self.dissmissThisView()
	}
	private func dissmissThisView(){
		UIView.animateWithDuration(0.3, animations: { () -> Void in
			self.dissmissThisView()
		})
	}
	
	
	
	
}
