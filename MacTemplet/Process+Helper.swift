//
//  Process+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/30.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

extension Process {

    static public func openApp(_ launchPath: String?, urlStr: String) {
        let pro = Process()
        pro.launchPath = launchPath
        if (pro.standardError != nil) {
            if let url = URL(string: urlStr) {
                NSWorkspace.shared.open(url)
            } else {
                print("链接无效")
            }
        } else {
            pro.launch()
        }
    }
}
