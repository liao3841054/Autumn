//
//  AlbumView.swift
//  summer
//
//  Created by Alex D. on 15/8/7.
//  Copyright (c) 2015年 Alex D. All rights reserved.
//

import UIKit

class AlbumView: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AlbumViewCellDelegate {
    
    var exitBlock:(() -> Void)?
    var urlArray:[String] = []
    
    var indexPath: NSIndexPath!
    var collectionView:UICollectionView!
    let identifier = "Cell"
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func layoutSubviews() {
        
        if(collectionView != nil){ return }
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = UICollectionViewScrollDirection.Horizontal
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
        collectionView = UICollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.clearColor()//背景色为透明
        collectionView.pagingEnabled = true//每次滚一页
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.registerClass(AlbumViewCell.self, forCellWithReuseIdentifier: identifier)
        self.addSubview(collectionView)
        
        if(indexPath != nil){
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
    }
    
    //MARK: UIColection delegate
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return 20
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        return CGSizeMake(self.frame.size.width, self.frame.size.height)
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! AlbumViewCell
        cell.imageUrl = self.urlArray[0]
        cell.delegate = self
        return cell
    }
    
    //MARK: AlbumViewCellDelegate
    func albumViewCellSignalClick() {
        self.exitBlock?()
    }
}

protocol AlbumViewCellDelegate {
    func albumViewCellSignalClick()
}
class AlbumViewCell: UICollectionViewCell ,UIScrollViewDelegate {
    
    var delegate:AlbumViewCellDelegate?
    var imageUrl:String? {
        set {
            if let value = newValue {
                vScrollView.zoomScale = 1
                vImage.sd_setImageWithURL(NSURL(string: value), placeholderImage: nil)
            }
        }
        get {
            return nil
        }
    }
    
    private var vScrollView: UIScrollView!
    private var vImage: UIImageView!
    
//    var startContentOffsetX :CGFloat!
//    var startContentOffsetY :CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        vImage = UIImageView()
        vImage.frame.size = frame.size
        //        self.img.clipsToBounds = true
        vImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        vScrollView = UIScrollView()
        vScrollView.frame.size = frame.size
        vScrollView.addSubview(vImage)
        
        vScrollView.delegate = self
        vScrollView.minimumZoomScale = 1.0 //0.5
        vScrollView.maximumZoomScale = 5.0 //2
        vScrollView.showsVerticalScrollIndicator = false
        vScrollView.showsHorizontalScrollIndicator = false
        
        
        let doubleTapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
        doubleTapGesture.numberOfTapsRequired = 2
        vScrollView.addGestureRecognizer(doubleTapGesture)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapAction:")
        tapGesture.numberOfTapsRequired = 1
        vScrollView.addGestureRecognizer(tapGesture)
        tapGesture.requireGestureRecognizerToFail(doubleTapGesture) //双击失败后执行单击
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: ScrollView delegate
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return vImage
    }
    #if true
    func scrollViewDidZoom(scrollView: UIScrollView) {
        let Ws = vScrollView.frame.size.width - vScrollView.contentInset.left - vScrollView.contentInset.right
        let Hs = vScrollView.frame.size.height - vScrollView.contentInset.top - vScrollView.contentInset.bottom
        let W = vImage.frame.size.width
        let H = vImage.frame.size.height
        var rct = vImage.frame
        rct.origin.x = max((Ws - W) * 0.5, 0)
        rct.origin.y = max((Hs - H) * 0.5, 0)
        vImage.frame = rct
    }
    #else
    func scrollViewDidZoom(scrollView: UIScrollView) {
    //缩小图片的时候把图片设置到scrollview中间
    let boundsSize = vScrollView.bounds.size
    var contentsFrame = vImage.frame
    if contentsFrame.size.width < boundsSize.width {
    contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
    } else {
    contentsFrame.origin.x = 0.0
    }
    if contentsFrame.size.height < boundsSize.height {
    contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
    } else {
    contentsFrame.origin.y = 0.0
    }
    vImage.frame = contentsFrame
    }
    #endif
    
    //MARK: tapgestuew action
    func tapAction(tap:UITapGestureRecognizer) {
        if(tap.numberOfTapsRequired == 2) {
            if (vScrollView.minimumZoomScale <= vScrollView.zoomScale && vScrollView.maximumZoomScale > vScrollView.zoomScale) {
                vScrollView.setZoomScale(vScrollView.maximumZoomScale, animated: true)
            }else {
                vScrollView.setZoomScale(vScrollView.minimumZoomScale, animated: true)
            }
        } else if(tap.numberOfTapsRequired == 1) {
            self.delegate?.albumViewCellSignalClick()
        }
    }
    
    
    
}

