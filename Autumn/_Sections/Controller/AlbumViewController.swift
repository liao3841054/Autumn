//
//  AlbumViewController.swift
//  GiftBox
//
//  Created by Ding Soung on 15/6/5.
//  Copyright (c) 2015年 xinyihezi. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var urlArray:[String] = []
    var index:CGFloat = 0
    
    private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clearColor()
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.size.height, self.view.frame.size.width), style: UITableViewStyle.Grouped)
        tableView.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5)
        tableView.transform = CGAffineTransformMakeRotation(-3.14159265358979323846264338327950288 * 0.5)
        tableView.pagingEnabled = true
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tintColor = UIColor(red:0.2, green:0.76, blue:0.43, alpha:1)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.contentInset = UIEdgeInsetsMake(0, -0.01, 0, -0.01)
        tableView.tableFooterView = UIView() //hide empty cell
        tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, 0, 0.01)) //hide head view shown in group
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        self.tabBarController?.tabBar.hidden = true
        
        self.tableView.reloadData()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    //MARK: tableView delegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.urlArray.count
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.view.frame.size.width
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        #if true
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? AlbumImageCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("AlbumImageCell", owner: self, options: nil).first as? AlbumImageCell
            cell?.frame.size.height = tableView.frame.size.width
            cell?.frame.size.width = tableView.frame.size.height
            cell?.accessoryType = UITableViewCellAccessoryType.None
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell?.transform = CGAffineTransformMakeRotation(3.14159265358979323846264338327950288 * 0.5)
            cell?.delegate = self
        }
        cell?.imageUrl = self.urlArray[indexPath.section]
        return cell!
        #else
            var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? AlbumImageCell
            if cell == nil {
                cell = AlbumImageCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
                cell?.frame.size.height = tableView.frame.size.width
                cell?.frame.size.width = tableView.frame.size.height
                cell?.accessoryType = UITableViewCellAccessoryType.None
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                cell?.transform = CGAffineTransformMakeRotation(3.14159265358979323846264338327950288 * 0.5)
                cell?.delegate = self
                
            }
            cell?.imageUrl = self.urlArray[indexPath.section]
            return cell!
        #endif
    }
}




