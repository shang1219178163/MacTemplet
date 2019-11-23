//
//  NSStatusItem+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSStatusItem {

    static func create(imageName: String?) -> NSStatusItem {
        
        var image = NSApplication.appIcon.resize(CGSize(width: 17, height: 17), isPixels: true);
        if imageName != nil && (NSImage(named: imageName!) != nil) {
            image = NSImage(named: imageName!)!
        }
        
        let statusItem: NSStatusItem = {
            let item = NSStatusBar.system.statusItem(withLength: -2)
            item.button?.cell?.isHighlighted = false;
            item.button?.image = image;
            item.button?.toolTip = NSApplication.appName;
            
            return item;
        }()
        return statusItem;
    }
}
