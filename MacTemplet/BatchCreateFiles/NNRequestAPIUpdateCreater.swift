//
//  NNRequestAPIUpdateCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/7.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

/// 修改
class NNRequestAPIUpdateCreater: NSObject {

    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

/// 修改
@objcMembers class \(name): IOPBaseAPIManager {
    
    var recordID: String = ""
        
    var dataModel = NSObject()

    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = ["id": recordID,

        ]
        return params
    }
    
    override func validateParamsData() -> Bool {
//        if recordID.count < 4 {
//            IOPProgressHUD.showText("ID不能为空")
//            return false
//        }
        return true
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
