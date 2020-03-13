//
//  NNRequestAPIUpdateCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/7.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

// 修改
class NNRequestAPIUpdateCreater: NSObject {

    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

/// 修改
@objcMembers class \(name): IOPBaseAPIManager {
    
    @objc var ID: String = ""
        
    @objc var dataModel = NSObject()

    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = ["id": ID,

        ]
        return params
    }
    
    override func validateParamsData() -> Bool {
//        if name.count < 4 {
//            IOPProgressHUD.showText("用户名必须大于等于4位")
//            return false;
//        }
        return true;
    }
}

"""
    }
}
