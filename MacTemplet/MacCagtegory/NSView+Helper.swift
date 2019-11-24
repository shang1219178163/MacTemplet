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
    
    
    func setbulrEffct(){
        let blurView = NSView(frame: self.bounds)
        blurView.wantsLayer = true
        blurView.layer?.backgroundColor = NSColor.clear.cgColor
        blurView.layer?.masksToBounds = true
        blurView.layerUsesCoreImageFilters = true
        blurView.layer?.needsDisplayOnBoundsChange = true
        
        let satFilter = CIFilter(name: "CIColorControls")
        satFilter?.setDefaults()
        satFilter?.setValue(NSNumber(value: 2.0), forKey: "inputSaturation")
        
        let blurFilter = CIFilter(name: "CIGaussianBlur")
        blurFilter!.setDefaults()
        blurFilter?.setValue(NSNumber(value: 1.0), forKey: "inputRadius")
        
        blurView.layer?.backgroundFilters = [satFilter, blurFilter]        
        self.addSubview(blurView)
        blurView.layer?.needsDisplay()
    }
    
    /// 插入模糊背景
    @available(OSX 10.14, *)
    func addVisualEffectView(_ rect: CGRect = .zero) -> NSVisualEffectView {
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
