//
//  NNCopyRightModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//
    
import Cocoa
import CocoaExpand

@objcMembers class NNCopyRightModel: NSObject {

    /// 类顶部版权信息
    static func getCopyRight(with name: String, type: String) -> String {
        let dateStr = DateFormatter.stringFromDate(Date(), fmt: kDateFormatMinute)
        
        var result = "//\n"
        result += "//\t\(name).\(type)\n"
        result += "//\t\(NSApplication.appBundleName)\n"
        result += "//\n"
        result += "//\tCreated by \(NSApplication.macUserName) on \(dateStr)\n"
        result += "//\tCopyright © \(dateStr.substringTo(3)) \(NSApplication.macUserName). All rights reserved.\n"
        result += "//\n"
        return result;
    }
    
    
    
}
