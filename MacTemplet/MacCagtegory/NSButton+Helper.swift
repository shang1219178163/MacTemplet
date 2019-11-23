//
//  NSButton+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSButton {

    @available(OSX 10.12.2, *)
    static func create(_ rect: CGRect) -> Self {
        let view: NSButton = self.init(frame: rect);
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .regularSquare
        view.bezelColor = NSColor.lightGreen

        return view as! Self;
    }
}
