//
//  CAGradientLayer+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/2/26.
//  Copyright © 2019 BN. All rights reserved.
//

import Cocoa

@objc public extension CAGradientLayer{
    
    static func layerRect(_ rect: CGRect = .zero, colors: [Any], start: CGPoint, end: CGPoint) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = rect
        layer.colors = colors
        layer.startPoint = start
        layer.endPoint = end
        
        return layer
    }
    
    static func gradientColor(_ from: NSColor, to: NSColor) -> [Any] {
       return [from.cgColor, to.cgColor]
    }
    
    /// 十六进制字符串
    static func gradientColorHex(_ from: String, fromAlpha: CGFloat, to: String, toAlpha: CGFloat = 1.0) -> [Any] {
        return [NSColor.hex(from, a: fromAlpha).cgColor, NSColor.hex(to, a: toAlpha).cgColor]
    }
    
    /// 0x开头的十六进制数字
    static func gradientColorHexValue(_ from: Int, fromAlpha: CGFloat, to: Int, toAlpha: CGFloat = 1.0) -> [Any] {
        return [NSColor.hexValue(from, fromAlpha).cgColor, NSColor.hexValue(to, toAlpha).cgColor]
    }
    
    static var defaultColors: [Any] {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as? [Any];
            if obj == nil {
                obj = [NSColor.hexValue(0x6cda53, 0.9).cgColor, NSColor.hexValue(0x1a965a, 0.9).cgColor]
                objc_setAssociatedObject(self, RuntimeKeySelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
