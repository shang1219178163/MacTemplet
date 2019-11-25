//
//  NSView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc extension NSView {
    
    public var sizeWidth: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var rectTmp = frame;
            rectTmp.size.width = newValue;
            frame = rectTmp;
        }
    }
    
    public var sizeHeight: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var rectTmp = frame;
            rectTmp.size.height = newValue;
            frame = rectTmp;
        }
    }
    
    public var size: CGSize  {
        get {
            return frame.size
        }
        set{
            var rectTmp = frame;
            rectTmp.size = newValue;
            frame = rectTmp;
        }
    }
    
    public var originX: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var rectTmp = frame;
            rectTmp.origin.x = newValue;
            frame = rectTmp;
        }
    }
    
    public var originY: CGFloat {
        get {
            return frame.origin.y
        }
        set {
//            frame.origin.y = newValue
            var rectTmp = frame;
            rectTmp.origin.y = newValue;
            frame = rectTmp;
        }
    }
    
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
//            frame.origin = newValue
            var rectTmp = frame;
            rectTmp.origin = newValue;
            frame = rectTmp;
        }
    }
    
    public var minX: CGFloat {
        return frame.minX
    }
    
    public var minY: CGFloat {
        return frame.minY
    }
    
    public var midX: CGFloat {
        return frame.midX
    }
    
    public var midY: CGFloat {
        return frame.midY
    }
    
    public var maxX: CGFloat {
        return frame.maxX
    }
    
    public var maxY: CGFloat {
        return frame.maxY
    }
    /// 图层调试
    public func getViewLayer(_ lineColor: NSColor = .blue) {
        let subviews = self.subviews;
        if subviews.count == 0 {
            return;
        }
        for subview in subviews {
            subview.layer?.borderWidth = kW_LayerBorder;
            subview.layer?.borderColor = lineColor.cgColor;
 //            subview.layer?.borderColor = UIColor.clear.cgColor;

            subview.getViewLayer();
         }
     }
    /// 图层调试(兼容OC)
    public func getViewLayer() {
        getViewLayer(.blue)
    }
    
    /// 寻找子视图
    public func findSubview(type: NSResponder.Type, resursion: Bool)-> NSView? {
        for e in self.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return e.element;
            }
        }
        
        if resursion == true {
            for e in self.subviews.enumerated() {
                let tmpView = e.element.findSubview(type: type, resursion: resursion)
                if tmpView != nil {
                    return tmpView;
                }
            }
        }
        return nil;
    }
    
    /// 获取父视图的 NSScrollView
    public func supScrollView() -> NSScrollView? {
        var supView = self.superview
        while supView?.isKind(of: NSScrollView.classForCoder()) == false {
            supView = supView?.superview;
        }
        
        if supView?.isKind(of: NSWindow.classForCoder()) == true {
            return nil
        }
        return (supView as! NSScrollView)
    }
    
    /// 插入模糊背景
    @available(OSX 10.14, *)
    public func addVisualEffectView(_ rect: CGRect = .zero) -> NSVisualEffectView {
        let tmpRect = CGRect.zero.equalTo(rect) == false ? rect : self.bounds;
        let effectView = NSVisualEffectView(frame: tmpRect)
        effectView.blendingMode = .behindWindow
        effectView.material = .underWindowBackground
        effectView.state = .active
//        effectView.appearance = NSAppearance(named: .vibrantDark)
        addSubview(effectView)
        return effectView;
    }
}
