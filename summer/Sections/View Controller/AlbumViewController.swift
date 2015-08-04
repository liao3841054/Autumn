//
//  AlbumViewController.swift
//  GiftBox
//
//  Created by Ding Soung on 15/6/5.
//  Copyright (c) 2015年 xinyihezi. All rights reserved.
//

import UIKit

class AlbumViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,AlbumImageViewDelegate {
    
    var urlArray:[String] = [
        "http://i.imgur.com/iCH2RvP.jpg",
        "http://ww2.sinaimg.cn/large/ce744de6gw1eih8x32sacj21400p0wl8.jpg",
        "http://ww4.sinaimg.cn/bmiddle/620ae61atw1eihftaqjvxj20vk0no40y.jpg",
    ]
    var index:CGFloat = 0
    
    private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGrayColor()
        
        tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.height, self.view.frame.size.width), style: UITableViewStyle.Grouped)
        tableView.center = CGPointMake(self.view.frame.size.width * 0.5, self.view.frame.size.height * 0.5)
        tableView.transform = CGAffineTransformMakeRotation(-3.14159265358979323846264338327950288 * 0.5)
        tableView.pagingEnabled = true
        
        tableView.backgroundColor = UIColor.clearColor()
        tableView.tintColor = UIColor(red:0.2, green:0.76, blue:0.43, alpha:1)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        tableView.contentInset = UIEdgeInsetsMake(0, -0.01, 0, -0.01)
        tableView.tableFooterView = UIView.new() //hide empty cell
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
    
    //MARK: AlbumImageView delegate
    func albumImageViewSignalTaped() {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
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
        /*
        let cellIdentifer = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifer) as UITableViewCell?
        if cell == nil {
        cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentifer)
        cell?.accessoryType = UITableViewCellAccessoryType.None
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        cell?.backgroundColor = UIColor.clearColor()
        
        //set View
        let view = AlbumImageView(frame: self.view.frame)
        view.delegate = self
        
        cell?.contentView.addSubview(view)
        }
        cell!.contentView.transform = CGAffineTransformMakeRotation(3.14159265358979323846264338327950288 * 0.5)
        return cell!
        */
        var cell = tableView.dequeueReusableCellWithIdentifier("cell") as? AlbumImageCell
        if cell == nil {
            cell = AlbumImageCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cell")
            cell?.frame = self.tableView.frame
            cell?.accessoryType = UITableViewCellAccessoryType.None
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            //cell?.backgroundColor = UIColor.clearColor()
            
            cell?.delegate = self
            //cell?.contentView.transform = CGAffineTransformMakeRotation(3.14159265358979323846264338327950288 * 0.5)
        }
        //cell?.imageUrl = self.urlArray[indexPath.section]
        cell?.img.sd_setImageWithURL(NSURL(string: self.urlArray[indexPath.section]), placeholderImage: UIImage(named: ""))
        return cell!
    }
}




