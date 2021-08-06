//
//  UUTabViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/30.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

class UUTabViewController: NSTabViewController {
    
    lazy var list: [[String]] = {
        let list = [["JsonToModelController", "JSON转模型", ],
                    ["ProppertyLazyController", "OC属性Lazy",],
                    ["NNBatchClassCreateController", "iOS类文件批量生成",],
                    ]
        return list
    }()

    // MARK: -lazy
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        tabStyle = .toolbar
        transitionOptions = .crossfade
        tabView.tabViewBorderType = .none

//        tabView.addItems(list)
//        selectedTabViewItemIndex = 0
        DDLog(tabView.tabViewItems)

//        var items: [NSTabViewItem] = []
//        for e in list.enumerated() {
////            let controller = NSCtrFromString(e.element.first!)
//            let controller = NNBatchClassCreateController()
//            if e.element.count > 1 {
//                controller.title = controller.title ?? e.element[1]
//            }
//
//            let item = NSTabViewItem(viewController: controller)
//            item.view = controller.view
//            item.image = NSImage(named: "NSPreferencesGeneral")
//            tabView.tabViewItems.append(item)
//        }
        
        let controller = NNBatchClassCreateController()
        let item = NSTabViewItem(viewController: controller)
        item.view = controller.view
        item.image = NSImage(named: "NSPreferencesGeneral")
        item.toolTip = "toolTip"
        tabView.addTabViewItem(item)

        
//        tabView.tabViewItems = items
//        DDLog(tabView.tabViewItems)
    }
    
    override func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        super.toolbarDefaultItemIdentifiers(toolbar)

        var arr = Array<NSToolbarItem.Identifier>()
        for item in self.tabViewItems {
            if let identifier = item.identifier {
                arr.append(NSToolbarItem.Identifier.init(identifier as! String))
            }
        }

        //insert flexible spaces at first and last index
        arr.insert(NSToolbarItem.Identifier.flexibleSpace, at: 0)
        arr.append(NSToolbarItem.Identifier.flexibleSpace)

        return arr
    }
    
    // MARK: -delegate
    override func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        let index = tabView.indexOfTabViewItem(tabViewItem!)
        print(index)
    }
}
