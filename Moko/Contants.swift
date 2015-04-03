//
//  Contants.swift
//  Moko
//
//  Created by 黄伟华 on 15/3/31.
//  Copyright (c) 2015年 黄伟华. All rights reserved.
//

import UIKit

struct Constants {
    static let baseUrl = "http://www.moko.cc"
    
    struct interfacePath {
        static let sheyingPath = "/channels/post/28/"
        static let moterPath   = "/channels/post/23/"
        static let huazhuang   = "/channels/post/151/"
        static let sheji       = "/channels/post/41/"
        static let yishu       = "/channels/post/71/"
        static let guanggao    = "/channels/post/53/"
        static let yanyi       = "/channels/post/150/"
        static let youxi       = "/channels/post/148/"
        static let gengduo     = "/channels/post/94/"
    }
    
    struct parserString {
        static let indexParser  = "//ul[@class='post small-post']/div[@class='cover']/*"
        static let previewParser="//div[@class='pic dBd']/p[@class='picBox']/img"
    }
    
}
