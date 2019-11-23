//
//  NSFileManager+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc public extension FileManager{

    static func createFile(_ atPath: String, name: String, content: String, attributes: [FileAttributeKey : Any]?) -> Bool {
        let filePath = atPath + "/\(name)"
        return FileManager.default.createFile(atPath: filePath, contents: content.data(using: .utf8), attributes: attributes)
    }

//    static func isExistFile(name: String) -> Bool {
//        if let _ = NSClassFromString(name) {
//            print("✅_Objc文件存在: \(name)")
//            return true;
//        }
//        
//        let swiftClassName = "\(NSApplication.appBundleName).\(name)";
//        if let _ = NSClassFromString(swiftClassName) {
//            print("✅_Swift文件存在: \(swiftClassName)")
//            return true;
//        }
//        print("❌_文件不存在: \(name)")
//        return false
//    }
}
