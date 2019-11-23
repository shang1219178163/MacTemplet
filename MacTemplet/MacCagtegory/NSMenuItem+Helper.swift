//
//  NSMenuItem+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc extension NSMenuItem {

    static public func create(title: String, keyEquivalent charCode: String, handler: @escaping (NSMenuItem) -> Void) -> NSMenuItem {
        let menuItem = NSMenuItem(title: title, action: nil, keyEquivalent: charCode)
        menuItem.addAction(handler)
        return menuItem;
    }
    /// 闭包回调
    public func addAction(_ handler: @escaping (NSMenuItem) -> Void) {
        objc_setAssociatedObject(self, UnsafeRawPointer(bitPattern: self.hashValue)!, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invoke(_:));
    }
    
    private func p_invoke(_ sender: NSMenuItem) {
        let handler = objc_getAssociatedObject(self, UnsafeRawPointer(bitPattern: self.hashValue)!) as! ((NSMenuItem) -> Void)
        handler(sender);
    }
}
