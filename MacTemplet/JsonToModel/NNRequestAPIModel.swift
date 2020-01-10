//
//  NNRequestAPIModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNRequestAPIModel: NSObject {

    static func getContent(with name: String, type: String) -> String {
        let copyRight = NNCopyRightModel.getCopyRight(with: "\(name)", type: type)
        return """
\(copyRight)

import UIKit

///
@objcMembers class \(name): IOPBaseAPIManager {
    
    @objc var dataModel: IOPDataModel = IOPDataModel()

    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = ["": "",
//                                           "username": dataModel.name,
//                                           "password": dataModel.password.md5,
//                                           "phone": dataModel.phone,
//                                           "code": dataModel.code,

        ]
        return params
    }
    
    override func validateParamsData() -> Bool {
//        if dataModel.name.count < 4 {
//            IOPProgressHUD.showText("用户名必须大于等于4位")
//            return false;
//        }
//
//        if dataModel.password.count < 6 {
//            IOPProgressHUD.showText("密码必须大于等于6位")
//            return false;
//        }
//
//        if dataModel.phone.count != 11 {
//            IOPProgressHUD.showText("请输入正确的手机号码")
//            return false;
//        }
        return true;
    }
}

/// 注册数据模型
@objcMembers class IOPDataModel: NSObject {
    @objc var name: String = ""
    @objc var password: String = ""
    @objc var phone: String = ""
    @objc var code: String = ""
    
}

"""
    }
}
