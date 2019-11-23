//
//  NSTabView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSTabView {

    static func create(_ rect: CGRect) -> Self {
        let view: NSTabView = self.init(frame: rect);
        view.tabPosition = .top
        view.tabViewBorderType = .line
        
        return view as! Self;
    }
    
    /*
    /// 添加子视图
    /// - Parameter items: @[@[@"JsonToModelNewController", @"json转模型", ],
    @[@"ProppertyLazyController", @"属性Lazy",],
    @[@"AuthorInfoController", @"其他",],
    @[@"NSTestViewController", @"测试模块",],
    @[@"MacTemplet.TmpViewController",],
    ];
     */
    func addItems(_ items: [[String]]) {
        for e in items.enumerated() {
            let controller = NSCtrFromString(e.element.first!)
            if e.element.count > 1 {
                controller.title = controller.title ?? e.element[1]
            }
            
            let item = NSTabViewItem(viewController: controller)
            item.view = controller.view
            addTabViewItem(item)
        }
    }
    
}
