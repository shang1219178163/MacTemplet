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
    func setupSubViewMultiplier(_ multiplier: CGFloat, at index: Int) {
        for e in subviews.enumerated() {
            if e.offset == index {
                if self.orientation == .horizontal {
                    e.element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true

                } else {
                    e.element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
                }
            }
        }
    }
    /// 设置子视图显示比例(此方法前请设置 .orientation)
    func setupSubViewsMultipliers(_ multipliers: [CGFloat]) {
        if multipliers.count < subviews.count {
            return;
        }
        
        for e in subviews.enumerated() {
            if e.offset == subviews.count - 1 {
                // 最后一个视图用于自由填充,避免布局错误
                return;
            }
            
            if e.offset >= multipliers.count {
                return;
            }
            
            let multiplier: CGFloat = multipliers[e.offset]
            if self.orientation == .horizontal {
                e.element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true

            } else {
                e.element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
            }
        }
    }


}
