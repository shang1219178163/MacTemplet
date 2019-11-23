//
//  NSScreen+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc public extension NSScreen {
    
    static var sizeWidth: CGFloat {
        return NSScreen.main!.frame.size.width
    }
    
    static var sizeHeight: CGFloat {
        return NSScreen.main!.frame.size.height
    }
    
    static var statusBarHeight: CGFloat {
        return 20.0
    }
    
    static var navBarHeight: CGFloat {
        return 44.0
    }
    
    static var barHeight: CGFloat {
        return (NSScreen.statusBarHeight + NSScreen.navBarHeight)
    }
    
    static var tabBarHeight: CGFloat {
        return 49.0
    }
}
