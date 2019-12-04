//
//  NSSearchField+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/25.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSSearchField {

    /// 创建近期搜索记录下拉菜单
    static func createRecentMenu(_ handler: ((NSMenuItem) -> Void)? = nil) -> NSMenu {
        let menu = NSMenu(title: "Recents")

        let recentTitleItem = NSMenuItem(title: "搜索记录", action: nil, keyEquivalent: "")
        recentTitleItem.tag = NSSearchField.recentsTitleMenuItemTag
        menu.addItem(recentTitleItem)
        
        let placeholder = NSMenuItem(title: "Item", action: nil, keyEquivalent: "")
        placeholder.tag = NSSearchField.recentsMenuItemTag
        menu.addItem(placeholder)

        menu.addItem( NSMenuItem.separator() )

        let clearItem = NSMenuItem(title: "清除记录", action: nil, keyEquivalent: "")
        clearItem.tag = NSSearchField.clearRecentsMenuItemTag
        menu.addItem(clearItem)
        
        let emptyItem = NSMenuItem(title: "搜索记录为空", action: nil, keyEquivalent: "")
        emptyItem.tag = NSSearchField.noRecentsMenuItemTag
        menu.addItem(emptyItem)
        
        if handler == nil {
            return menu
        }
        
        for e in menu.items {
            e.addAction(handler!)
        }
        return menu
    }
    
}
