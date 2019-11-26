//
//  FileController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

class FileController: NSViewController {
     
    override func viewDidLoad() {
        super.viewDidLoad()
         
        //在桌面上创建一个文件
        FileManager.createFile(content: "aGVsbG8gd29ybGQ=", name: "test.txt", openDir: true)
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        let path = "/Users/\(ProcessInfo.processInfo.userName)/Downloads"
        DDLog(path, FileManager.downloadsDir)
        
        
        let result = Bundle.readPath(forResource: "THML5常用控件总结", ofType: "txt")
        DDLog(result)
//        if let path = Bundle.main.path(forResource: "THML5常用控件总结", ofType: "txt") {
//            do {
//                let data = try String(contentsOfFile: path, encoding: .utf8)
//                let myStrings = data.components(separatedBy: .newlines)
//                let result = myStrings.joined(separator: ", ")
//                DDLog(myStrings)
//
//            } catch {
//                print(error)
//            }
//        }
    
    }
}
