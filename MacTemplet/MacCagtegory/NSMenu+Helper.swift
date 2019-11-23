//
//  NSMenu+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSMenu {

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
