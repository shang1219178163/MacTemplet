//
//  NNRequestAPIListCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

/// 列表
class NNRequestAPIListCreater: NSObject {

    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

/// 列表
@objcMembers class \(name): IOPBaseAPIManager {
    
    var name: String = ""
    
    var pageModel = IOPPageModel(perPageCounts: UInt(IOPPageSize))!

    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = ["page" : pageModel.currPage,
                                           "page_item": pageModel.perPageCounts,
                                           "name": name,

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
        
    override func isOriginDic() -> Bool {
        return true
    }

    override func needLogin() -> Bool {
        return true
    }
              
    override func printLog() -> Bool {
        return true
    }
}

"""
    }
}
