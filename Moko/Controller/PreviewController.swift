//
//  PreviewController.swift
//  Moko
//
//  Created by 黄伟华 on 15/4/2.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit
import GoogleMobileAds
class PreviewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    @IBOutlet var bannerView: GADBannerView!
    
    var path:String!
    var resultArray = [TFHppleElement]()

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "列表"
        
        self.bannerView.adUnitID = "ca-app-pub-9740809110396658/1151923524"
        self.bannerView.rootViewController = self
        var deviceRequest:GADRequest = GADRequest()
        deviceRequest.testDevices = ["59dacc3883b1287897acd50d68a2617275d9b323"]
        self.bannerView.loadRequest(deviceRequest)
        
        request()
    }
    
    func request(){
        PaserHelper.getHtmlNodes("\(path)",parser: Constants.parserString.previewParser, sucessBlock: { (respondData, state) -> () in
            println(respondData)
            self.resultArray.removeAll(keepCapacity: false)
            var array = respondData as! [TFHppleElement]
            self.resultArray+=array
            
            self.collectionView.reloadData()
        })
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PreviewCell
        cell.imageView.image = nil
        var element = resultArray[indexPath.row]
        cell.imageView.loadWithURL(NSURL(string: element.attributes["src2"] as! String), placeholer: nil, showActivityIndicatorView: true)
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
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! PreviewCell
        
        var ivc:ESImageViewController = ESImageViewController()
        ivc.closeButton.hidden = false
        ivc.tappedThumbnail = cell.imageView
        ivc.image = cell.imageView.image
        self.presentViewController(ivc, animated: true) { () -> Void in
            
        }
        
    }
}
