//
//  NSViewController+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSViewController {

    var tbView: NSTableView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as? NSTableView;
            if obj == nil {
                obj = NSTableView.create(view.bounds);

                objc_setAssociatedObject(self, RuntimeKeySelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 关联NSMutableArray 数据容器
    var dataList: NSMutableArray {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as? NSMutableArray;
            if obj == nil {
                obj = [];
                objc_setAssociatedObject(self, RuntimeKeySelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
}
