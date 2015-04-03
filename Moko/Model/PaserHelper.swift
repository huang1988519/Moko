//
//  PaserHelper.swift
//  Moko
//
//  Created by 黄伟华 on 15/3/31.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit

class PaserHelper: NSObject{
    
    class func getHtmlNodes(path:String,parser:String,sucessBlock:SucessHandle){
        var url = "\(Constants.baseUrl)\(path)"
        var network=Network()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        network.requestWithUrl(url, sucessHander: { (respond, state) -> () in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false

            if state==0{//sucess
                var data = respond as NSData
                var doc  = TFHpple(HTMLData: data)

                if let _temp=doc{
                }else{
                    
                    println("没有解析出内容!")
                    return
                }
                var array = doc.searchWithXPathQuery(parser)
                
                if let temp = array{
                    sucessBlock(temp,state:0)
                }else{
                    sucessBlock(nil,state:-1)
                }
            }else{//false
                sucessBlock(nil,state:state)
            }
        })
    }
    
}
