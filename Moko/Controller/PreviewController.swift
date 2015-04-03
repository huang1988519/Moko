//
//  PreviewController.swift
//  Moko
//
//  Created by 黄伟华 on 15/4/2.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit

class PreviewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,XHImageViewerDelegate{

    var path:String!
    var resultArray = [TFHppleElement]()

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request()
    }
    
    func request(){
        PaserHelper.getHtmlNodes("\(path)",parser: Constants.parserString.previewParser, sucessBlock: { (respondData, state) -> () in
            println(respondData)
            self.resultArray.removeAll(keepCapacity: false)
            var array = respondData as [TFHppleElement]
            self.resultArray+=array
            
            self.collectionView.reloadData()
        })
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as PreviewCell
        var element = resultArray[indexPath.row]
        cell.imageView.loadWithURL(NSURL(string: element.attributes["src2"] as String), placeholer: nil, showActivityIndicatorView: true)
        return cell
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultArray.count
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let w = CGRectGetWidth(self.view.bounds) - 30*2
        var size = CGSizeMake(w, w*1.5)
        return size
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as PreviewCell
        
        var viewer =  XHImageViewer()
        viewer.delegate = self
        viewer.showWithImageViews([cell.imageView], selectedView: cell.imageView)
    }

}
