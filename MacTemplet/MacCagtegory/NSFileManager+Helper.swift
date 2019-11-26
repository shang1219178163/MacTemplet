//
//  NSFileManager+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc public extension FileManager{
    /// 下载目录
    static var downloadsDir = FileManager.default.urls( for: .downloadsDirectory, in:.userDomainMask).first;

    static func createFile(_ atPath: String, name: String, content: String, attributes: [FileAttributeKey : Any]?, isCover: Bool = true) -> Bool {
//        let filePath = atPath + "/\(name)"
        let filePath = isCover ? "\(atPath)/\(name)" :  "\(atPath)/\(name)_\(DateFormatter.stringFromDate(Date()))";
        return FileManager.default.createFile(atPath: filePath, contents: content.data(using: .utf8), attributes: attributes)
    }
    
    //根据文件名和路径创建文件
    static func createFile(content: String, name: String, dirUrl: URL? = FileManager.downloadsDir, openDir: Bool = true){
        guard let dirUrl = dirUrl else { return }
        let fileUrl = dirUrl.appendingPathComponent(name)

        let exist = FileManager.default.fileExists(atPath: fileUrl.path)
        if !exist {
            let data = content.data(using: .utf8)
            let isSuccess = FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: nil)
            print("文件创建结果: \(isSuccess)")
        }
        if openDir {
            NSWorkspace.shared.open(dirUrl)
        }
    }
}
