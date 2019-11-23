//
//  NSView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSView {

     /// 图层调试
    func getViewLayer(_ lineColor: NSColor = .blue) {
        let subviews = self.subviews;
        if subviews.count == 0 {
            return;
        }
        for subview in subviews {
            subview.layer!.borderWidth = kW_LayerBorder;
            subview.layer!.borderColor = lineColor.cgColor;
 //            subview.layer.borderColor = UIColor.clear.cgColor;

            subview.getViewLayer();
         }
     }
    
    
    func getViewLayer() {
        getViewLayer(.blue)
    }
    
}
