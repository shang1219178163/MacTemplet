
//
//  NSPopover+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSPopover {

    static func create(controller: NSViewController) -> Self {
        let popover: NSPopover = self.init()
        popover.appearance = NSAppearance(named: .aqua)
        popover.behavior = .transient
        popover.contentViewController = controller;
        return popover as! Self;
    }
}
