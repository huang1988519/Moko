//
//  Network.swift
//  Moko
//
//  Created by 黄伟华 on 15/3/31.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit

typealias SucessHandle = (AnyObject?,state:Int) -> ()
class Network: NSObject,NSURLConnectionDataDelegate {
    var receiveData:NSMutableData?
    var _sucessBlock:SucessHandle?
    var _responseState:NSHTTPURLResponse?
    
    func requestWithUrl(url:String?,sucessHander:SucessHandle?){
        if url==nil {
            return
        }
        
        println("start request \(url)")
        
        var request = NSURLRequest(URL: NSURL(string: url!)!)
        var connection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        
        _sucessBlock = sucessHander
    }
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSHTTPURLResponse) {

        _responseState = response
        println("respond:\(_responseState)")
        receiveData = NSMutableData()
    }
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
        receiveData?.appendData(data)
    }
    func connectionDidFinishLoading(connection: NSURLConnection) {
        var string = NSString(data: receiveData!, encoding: NSUTF8StringEncoding)

        if string != nil{
            if let sucess = _sucessBlock{
                _sucessBlock!(receiveData,state: 0)
            }
        }else
        {
            if let sucess = _sucessBlock{
                _sucessBlock!("未知错误\(_responseState?.description)",state: -2)
            }
        }
       
    }
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        debugPrintln("error: \(error)")
        if let sucess = _sucessBlock{
            _sucessBlock!("网络错误，请重试",state: -1)
        }
    }

}
