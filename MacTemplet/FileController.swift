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
    
}
