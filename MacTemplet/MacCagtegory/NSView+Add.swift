//
//  NSView+Add.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSView {

    var center: CGPoint {
        get {
            return CGPoint(x: frame.origin.x + frame.size.width*0.5,
                           y: frame.origin.y + frame.size.height*0.5)
        }
        set {
            self.frame = CGRect(x: newValue.x - frame.size.width*0.5,
                                y: newValue.y - frame.size.height*0.5,
                                width: frame.size.width,
                                height: frame.size.height)
        }
    }
    
     var lineTop: NSView {
         get {
             var obj = objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as? NSView;
             if obj == nil {
                 obj = NSView(frame: CGRect(x: 0, y: 0, width: frame.width, height: kH_LINE_VIEW));
                 obj!.layer?.backgroundColor = NSColor.line.cgColor;

                 objc_setAssociatedObject(self, RuntimeKeySelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
             }
             return obj!;
         }
         set {
             objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         }
     }
     
     var lineBottom: NSView {
         get {
             var obj = objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as? NSView;
             if obj == nil {
                 obj = NSView(frame: CGRect(x: 0, y: frame.maxY - kH_LINE_VIEW, width: frame.width, height: kH_LINE_VIEW));
                 obj!.layer?.backgroundColor = NSColor.line.cgColor;

                 objc_setAssociatedObject(self, RuntimeKeySelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
             }
             return obj!;
         }
         set {
             objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
         }
     }
    
}
