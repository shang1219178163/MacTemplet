//
//  NSSegmentedControl+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSSegmentedControl {

    var items: [String] {
        get {
            return objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as! [String]
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            segmentCount = newValue.count;
            selectedSegment = 0;
            for e in newValue.enumerated() {
                self.setLabel(e.element, forSegment: e.offset)
            }
        }
    }
    
}
