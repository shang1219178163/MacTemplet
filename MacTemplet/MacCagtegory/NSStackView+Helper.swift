//
//  NSStackView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSStackView {


    static func create(_ rect: CGRect, spacing: CGFloat = 10.0) -> Self {
        let view: NSStackView = self.init(frame: rect);
//        view.autoresizingMask = [.width, .height];
        //设置子视图间隔
        view.spacing = spacing
        //子视图的高度或宽度保持一致
        view.distribution = .fillEqually
        
        return view as! Self;
    }
    
    /// 设置子视图显示比例(此方法前请设置 .orientation)
    func setSubViewMultiplier(_ multiplier: CGFloat, at index: Int) {
        if index < subviews.count {
            let element: NSView = subviews[index];
            if self.orientation == .horizontal {
                element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true

            } else {
                element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
            }
        }
    }
    
//    func setupSubViewMultiplier(_ multiplier: CGFloat, at index: Int) {
//        for e in subviews.enumerated() {
//            if e.offset == index {
//                if self.orientation == .horizontal {
//                    e.element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
//
//                } else {
//                    e.element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
//                }
//            }
//        }
//    }

}
