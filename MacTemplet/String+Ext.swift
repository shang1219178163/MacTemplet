//
//  String+Ext.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/8/6.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa


public extension String{
    
    /// 获取前缀
    func getPrefix(with separates: [String]) -> String {
        var reult = ""
        for value in separates {
            if self.contains(value) {
                reult = self.components(separatedBy: value).first!
                break
            }
        }
        return reult
    }
}
