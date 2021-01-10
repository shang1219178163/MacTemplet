//
//  NNRequestAPIAddCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa


/// 新增
class NNRequestAPIAddCreater: NSObject {

    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

/// 新增
@objcMembers class \(name): IOPBaseAPIManager {
            
    var dataModel = NSObject()

    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = [:]
        return params
    }
    
    override func validateParamsData() -> Bool {
//        if ID.count < 4 {
//            IOPProgressHUD.showText("ID不能为空")
//            return false;
//        }
        return true;
    }
            
    override func isOriginDic() -> Bool {
        return true
    }

//    override func needLogin() -> Bool {
//        return true
//    }
            
    override func printLog() -> Bool {
        return true
    }
}

"""
    }
}
