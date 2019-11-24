//
//  NSWindow+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSWindow {
    /// 默认大小
    static var defaultRect: CGRect {
        return CGRectMake(0, 0, kScreenWidth*0.4, kScreenHeight*0.5)
    }

    static func create(_ rect: CGRect = NSWindow.defaultRect, title: String = NSApplication.appName) -> NSWindow {
    //        let style = NSWindow.StyleMask.titled.rawValue | NSWindow.StyleMask.closable.rawValue | NSWindow.StyleMask.miniaturizable.rawValue | NSWindow.StyleMask.resizable.rawValue
        let style: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable]
        let window = NSWindow(contentRect: rect, styleMask: style, backing: .buffered, defer: false)
        window.title = title
        return window;
    }

    static func create(_ rect: CGRect = NSWindow.defaultRect, controller: NSViewController) -> NSWindow {
        let window = NSWindow.create(rect, title: controller.title ?? "")
        window.contentViewController = controller;
        return window;
    }
    
    static func createMain(_ rect: CGRect = NSWindow.defaultRect, title: String = NSApplication.appName) -> NSWindow {
        let window = NSWindow.create(rect, title: title)
        window.contentMinSize = window.frame.size;
        window.makeKeyAndOrderFront(self)
        window.center()
        return window;
    }
}
