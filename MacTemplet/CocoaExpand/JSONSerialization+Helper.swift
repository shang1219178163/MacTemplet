//
//  JSONSerialization+Helper.swift
//  CloudCustomerService
//
//  Created by Bin Shang on 2019/12/2.
//  Copyright © 2019 Xi'an iRain IoT. Technology Service CO., Ltd. . All rights reserved.
//

import Cocoa

@objc public extension JSONSerialization{

    
    /// NSObject -> NSData
    static func dataFromObj(_ obj: AnyObject) -> Data? {
        return obj.jsonData;
//        var data: Data?
//
//        switch obj {
//        case is Data:
//            data = (obj as! Data);
//
//        case is NSString:
//            data = (obj as! String).data(using: .utf8);
//
//        case is UIImage:
//            data = (obj as! UIImage).jpegData(compressionQuality: 1.0);
//
//        case is NSDictionary, is NSArray:
//            do {
//                data = try JSONSerialization.data(withJSONObject: obj, options: []);
//            } catch {
//                print(error)
//            }
//
//        default:
//            break;
//        }
//        return data;
    }
    
    /// data -> NSObject
    static func jsonObjectFromData(_ data: Data, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        return data.objValue
//        if JSONSerialization.isValidJSONObject(data) {
//            return nil;
//        }
//        do {
//            let obj: NSObject = try JSONSerialization.jsonObject(with: data, options: opt) as! NSObject
//            return obj;
//
//        } catch {
//            print(error)
//        }
//        return nil;
    }
    
    /// NSString -> NSObject/NSDiction/NSArray
    static func jsonObjectFromString(_ string: String, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        guard let data = string.data(using: .utf8) else { return nil}
        return JSONSerialization.jsonObjectFromData(data);
    }

    /// NSObject -> NSString
    static func jsonStringFromObj(_ obj: AnyObject) -> String {
        guard let data = JSONSerialization.dataFromObj(obj) else { return "" }
        let jsonString: String = String(data: data as Data, encoding: .utf8) ?? "";
        return jsonString;
    }

    
}
