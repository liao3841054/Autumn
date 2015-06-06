//
//  PhotoZoomView.swift
//  summer
//
//  Created by Ding Soung on 15/6/6.
//  Copyright (c) 2015年 Ding Soung. All rights reserved.
//

import UIKit

/*
class PhotoZoomView: UIView, UITableViewDelegate, UITableViewDataSource {
	
	var imgs:NSArray!
	var v_size:CGSize!
	var m_TableView:UITableView!
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	
	func updateImageDate(imageArr:NSArray, selectIndex index:NSInteger) {
		self.imgs = imageArr
		self.m_TableView.reloadData()
		if(index > 0 && index < self.imgs.count) {
			var row:NSInteger = index > 0 ? index : 0
			m_TableView.scrollToRowAtIndexPath(NSIndexPath(forRow: row, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)
		}
	}
	
	func initView() {
		m_TableView = UITableView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
		m_TableView.delegate = self
		m_TableView.dataSource = self
		m_TableView.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5)
		m_TableView.showsVerticalScrollIndicator = false
		m_TableView.transform = CGAffineTransformMakeRotation(-M_PI/2)
		m_TableView.pagingEnabled = true
		m_TableView.separatorStyle = UITableViewCellSeparatorStyle.None
		m_TableView.backgroundColor = UIColor.blackColor()
		self.addSubview(m_TableView)
	}
	
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return self.imgs.count
	}
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		
	}
	

}*/