//
//  NNRequestAPICreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa


///
class NNRequestAPICreater: NSObject {

    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

/// 
@objcMembers class \(name): IOPBaseAPIManager {
    
    var name: String = ""
    
    override func requestURI() -> String {
        return ""
    }
    
    override func requestType() -> IOPAPIRequestType {
        return .post
    }
    
    override func reformerParams() -> [AnyHashable : Any] {
        let params: [AnyHashable : Any] = ["name": name,

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
    /// 获取.h类内容
    static func getContentH(with name: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: "h")
        return """
\(copyRight)
#import "IOPBaseAPIManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface \(name) : IOPBaseAPIManager

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSObject *dataModel;

@end

NS_ASSUME_NONNULL_END

"""
    }
    
    /// 获取.h类内容
    static func getContentM(with name: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: "m")
        return """
\(copyRight)
#import "\(name).h"

@implementation \(name)

- (NSString *)requestURI{
    return @"";
}

- (IOPAPIRequestType)requestType{
    return IOPAPIRequestTypePost;
}

-(NSDictionary *)reformerParams{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    mdic[@"name"] = self.name ?  : @"";
    return mdic.copy;
}
        
- (BOOL)validateParamsData{
    return YES;
}

@end

"""
    }

}

