//
//  ViewController.swift
//  Moko
//
//  Created by 黄伟华 on 15/3/31.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit
import GoogleMobileAds
class ViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GADInterstitialDelegate{
    
    @IBOutlet var collectionView: UICollectionView!
    var interstital:GADInterstitial = GADInterstitial()
    
    var count:Int = 0
    
    var path:String!
    var resultArray = [TFHppleElement]()
    
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        
        
        self.collectionView.addPullToRefreshWithActionHandler { () -> Void in
            self.request()
        }
        self.collectionView.addInfiniteScrollingWithActionHandler { () -> Void in
            self.loadMore()
        }
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        debugPrint("viewdidAppeare")
    }
    func viewWillDisplay(){
        //发起请求
        count++
        request()
        
        displayAd()
    }
    
    func displayAd(){
        if count%3 != 0{
            return
        }
        debugPrint("展示广告")
        
        interstital = GADInterstitial()
        interstital.adUnitID = "ca-app-pub-9740809110396658/2628656728"
        interstital.delegate = self
        var deviceRequest:GADRequest = GADRequest()
        deviceRequest.testDevices = ["59dacc3883b1287897acd50d68a2617275d9b323"]
        interstital.loadRequest(deviceRequest)
        
    }
    func interstitialDidReceiveAd(ad: GADInterstitial!) {
        ad.presentFromRootViewController(self)
    }
    func interstitial(ad: GADInterstitial!, didFailToReceiveAdWithError error: GADRequestError!) {
        debugPrint("GAD ERROR: \(error)")
    }
    
    func request(){

        page = 1
        PaserHelper.getHtmlNodes("\(path)\(page).html", parser: Constants.parserString.indexParser) { (respondData, state) -> () in
            self.collectionView.pullToRefreshView.stopAnimating()
            self.resultArray.removeAll(keepCapacity: true)
            
            var respondArray = respondData as! [TFHppleElement];
            self.resultArray+=respondArray
            
            self.collectionView.reloadData()
        }
    }
    func loadMore(){
        page++
        
        PaserHelper.getHtmlNodes("\(path)\(page).html", parser: Constants.parserString.indexParser) { (respondData, state) -> () in
            self.collectionView.infiniteScrollingView.stopAnimating()

            
            var respondArray = respondData as! [TFHppleElement];
            if respondArray.count == 0{
                self.collectionView.showsInfiniteScrolling = false
                return
            }
            self.resultArray+=respondArray
            
            self.collectionView.reloadData()
        }
    }

    //collection datasource
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! FlipCell
        
        var element = self.resultArray[indexPath.row]
        element = element.firstChildWithTagName("img") as TFHppleElement
        
        println(element.attributes["src2"])
        if element.attributes["src2"] != nil{
            var imageUrl:String = element.attributes["src2"] as! String
            cell.imageView.sd_setImageWithURL(NSURL(string: imageUrl))
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resultArray.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var rect = self.view.bounds
        var w = (rect.width-15*2-10)/2
        return CGSizeMake(w, w)
    }
    //MARK: CollectionView Delegate
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        debugPrintln("点击 \(indexPath.row)")
        
        var element = self.resultArray[indexPath.row]
        element = element as TFHppleElement
        
        println(element.attributes["href"]!)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var indexPath: AnyObject = self.collectionView.indexPathsForSelectedItems()[0]
        var element = self.resultArray[indexPath.row]
        element = element as TFHppleElement
        
        var previewCtrl:PreviewController = segue.destinationViewController as! PreviewController
        previewCtrl.path = element.attributes["href"] as! String
    }
}

