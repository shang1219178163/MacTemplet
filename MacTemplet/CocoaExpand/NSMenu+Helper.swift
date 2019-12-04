//
//  NSMenu+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSMenu {
    /// 创建下拉菜单
    static func createMenu(withTitle title: String = "Menu", itemTitles: [String], handler: ((NSMenuItem) -> Void)? = nil) -> NSMenu {
        
        let menu = NSMenu(title: title)
        for e in itemTitles.enumerated() {
            let item = NSMenuItem(title: e.element, action: nil, keyEquivalent: "")
            if handler != nil {
                item.addAction(handler!)
            }
            menu.addItem(item)
        }
        return menu;
    }

    func addItem(withTitle title: String, keyEquivalent: String, handler: @escaping (NSMenuItem) -> Void) -> NSMenuItem {
        let item = addItem(withTitle: title, action: nil, keyEquivalent: keyEquivalent)
        item.addAction(handler)
        return item;
    }

    func insertItem(withTitle title: String, keyEquivalent charCode: String, at index: Int, handler: @escaping (NSMenuItem) -> Void) -> NSMenuItem {
        let item = insertItem(withTitle: title, action: nil, keyEquivalent: charCode, at: index)
        item.addAction(handler)
        return item;
    }
    
    
}
