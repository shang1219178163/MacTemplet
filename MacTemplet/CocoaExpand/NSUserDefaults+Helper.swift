
//
//  NSUserDefaults+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension UserDefaults{

    /// UserDefaults 二次封装
    static func setObject(_ object: Any?, forKey key: String) {
        self.standard.setValue(object, forKey: key)
    }
    /// UserDefaults 二次封装
    static func object(forKey key: String) -> Any? {
        self.standard.value(forKey: key)
    }
    /// UserDefaults 二次封装
    static func object(forKeyPath keyPath: String) -> Any? {
        self.standard.value(forKeyPath: keyPath)
    }
    /// UserDefaults 二次封装
    static func synchronize() {
         self.standard.synchronize()
     }
    /// UserDefaults 二次封装(遵守编解码协议的模型)
    static func setArcObject(_ value: Any?, forkey key: String) {
        if value == nil {
            return
        }
        let data = NSKeyedArchiver.archivedData(withRootObject: value!)
        self.standard.set(data, forKey: key)
    }
    /// UserDefaults 二次封装(遵守编解码协议的模型)
    static func arcObject(forKey key: String) -> Any? {
        let data = self.standard.object(forKey: key)
        if data == nil {
            return nil;
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data! as! Data)
    }
    
}
