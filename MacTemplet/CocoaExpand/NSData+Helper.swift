//
//  NSData+Helper.swift
//  CloudCustomerService
//
//  Created by Bin Shang on 2019/12/2.
//  Copyright © 2019 Xi'an iRain IoT. Technology Service CO., Ltd. . All rights reserved.
//

import Cocoa

@objc public extension NSData{
    /// NSData -> 转数组/字典
    var objValue: Any? {
        if JSONSerialization.isValidJSONObject(self) {
           return nil;
        }
        
        do {
            let obj: NSObject = try JSONSerialization.jsonObject(with: self as Data, options: []) as! NSObject
           return obj;
           
        } catch {
           print(error)
        }
        return nil;
    }
    
}

public extension Data{
    /// 转数组/字典
    var objValue: Any? {
        return (self as NSData).objValue;
    }
    
}
