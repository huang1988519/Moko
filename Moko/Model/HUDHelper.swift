//
//  HUDHelper.swift
//  Moko
//
//  Created by 黄伟华 on 15/4/27.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit


class HUDHelper: NSObject {
    static let hudHelper:HUDHelper = HUDHelper()
    
    var haveDisplayAlerts = [UIAlertView]()
    //单例
    class func shareInstance()->HUDHelper!{
        return hudHelper
    }
    
    func showNetworkErrorAlertWithMsg(var ErrorString:String!){
        
        var removeArray = [UIAlertView]()
        for item in haveDisplayAlerts{
            println("clearn alert with no animation")
            var alert = item as UIAlertView!
            alert.dismissWithClickedButtonIndex(0, animated: false)
            removeArray.append(alert)
        }
        for (index,item) in enumerate(removeArray){
            haveDisplayAlerts.removeAtIndex(index)
        }
        
        var alert = UIAlertView(title: "提示", message: ErrorString, delegate: nil, cancelButtonTitle: "确定")
        alert.show()
        
        haveDisplayAlerts.append(alert);
    }
}
