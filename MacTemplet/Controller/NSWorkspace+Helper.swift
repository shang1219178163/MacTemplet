//
//  NSWorkspace+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/5/15.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

public extension NSWorkspace {

    ///打开系统偏好设置中的隐私界面
    func openPreferencesPrivacy() {
        let string = "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
        if let url = URL(string: string) {
            NSWorkspace.shared.open(url)
        }
    }
    
}
