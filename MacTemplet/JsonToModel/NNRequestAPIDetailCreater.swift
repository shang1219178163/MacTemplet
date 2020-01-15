//
//  NNRequestAPIDetailCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/14.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNRequestAPIDetailCreater: NSObject {
    
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

///
@objcMembers class \(name): IOPBaseAPIManager {
    
    @objc var parkCode: String = ""
        
    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = ["parkCode" : parkCode,


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

