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
}
