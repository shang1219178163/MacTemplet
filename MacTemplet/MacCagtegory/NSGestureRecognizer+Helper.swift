//
//  NSGestureRecognizer+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc extension NSGestureRecognizer {

    /// 方法名称(用于自定义)
    public var funcName: String {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as? String;
            if obj == nil {
                obj = String(describing: self.classForCoder);
                objc_setAssociatedObject(self, RuntimeKeySelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    /// 闭包回调
    public func addAction(_ handler: @escaping (NSGestureRecognizer) -> Void) {
        objc_setAssociatedObject(self, UnsafeRawPointer(bitPattern: self.hashValue)!, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invoke(_:));
    }
    
    private func p_invoke(_ sender: NSGestureRecognizer) {
        let handler = objc_getAssociatedObject(self, UnsafeRawPointer(bitPattern: self.hashValue)!) as! ((NSGestureRecognizer) -> Void)
        handler(sender);
    }
    
}
