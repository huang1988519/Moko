//
//  AppDelegate.swift
//  Moko
//
//  Created by 黄伟华 on 15/3/31.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit
import GoogleMobileAds

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var bannerView:GADBannerView?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        
        //打开网络请求日志 
        AFNetworkActivityLogger.sharedLogger().startLogging()
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //menu controller
        var menuCtrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("menu") as! MenuController
        //root controller
        var rootController:XHTwitterPaggingViewer = XHTwitterPaggingViewer(leftViewController: menuCtrl)
        
        let titles = ["摄影","模特儿","化妆造型","设计插画","艺术","广告传媒","演艺","游戏动漫","更多行业"]
        let paths  = [Constants.interfacePath.sheyingPath,Constants.interfacePath.moterPath,Constants.interfacePath.huazhuang,Constants.interfacePath.sheji,Constants.interfacePath.yishu,Constants.interfacePath.guanggao,Constants.interfacePath.yanyi,Constants.interfacePath.youxi,Constants.interfacePath.gengduo]
        
        var index:Int = 0
        var controllers = [ViewController]()
        for title in titles{
            var mainCtrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainID") as! ViewController
            mainCtrl.title = title
            mainCtrl.path  = paths[index]
            controllers.append(mainCtrl)
            
            index++
        }
        rootController.viewControllers = controllers
        
        rootController.didChangedPageCompleted = { (page:NSInteger,title:String!) in
            debugPrintln("\(title) at \(page)")
            
            var ctrl = rootController.viewControllers[page] as! ViewController
            ctrl.viewWillDisplay()
        }

        
        var nav = UINavigationController(rootViewController: rootController)
        nav.navigationBar.tintColor = UIColor.blackColor()
        nav.navigationBar.translucent = false

        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

