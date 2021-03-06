//
//  TmpViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import CoreFoundation
import CocoaExpand
import NNButton

import Quartz

class TmpViewController: NSViewController {
    
    var itemList: [NSButton] = []
    
    lazy var windowCtrl: NSWindowController = {
        let controller = MainViewController()
//        let windowCtrl = NSWindowController(window: NSWindow.create(controller: controller))
        let windowCtrl = NNTabViewController(window: NSWindow.create(controller: controller))

        return windowCtrl
    }()
    
    lazy var windowOneCtrl: NSWindowController = {
        let controller = NNBatchClassCreateController()
        let rect = CGRectMake(0, 0, kScreenWidth*0.25, kScreenHeight*0.25)
        let windowCtrl = NSWindowController(window: NSPanel.create(rect, controller: controller))
        controller.view.frame = windowCtrl.window!.frame;
        controller.view.getViewLayer()
        return windowCtrl
    }()
        
    
    // MARK: -life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
                
        let list: [String] = ["显示NSWindowController", "sheet弹窗", "Button", "Button", "Button", "Button", ]
        itemList = NSButton.createGroupView(.zero, list: list, numberOfRow: 6, padding: 8, target: self, action: #selector(handleAction(_:)), inView: view);
        
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.1)
        NSButton.setupConstraint(frame, items: itemList, numberOfRow: 6, padding: 8)
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
//        DDLog(btnTwo.value(forKey: "mdicHighlighted"))
    }
    
    // MARK: -funtions
    @objc func handleAction(_ sender: NSButton) {
        switch sender.tag {
        case 0:
            windowCtrl.showWindow(sender)

        case 1:
            showSheetController()
            
        default:
            break
        }
    }
    
    func showSheetController() {
        let controller = NNBatchClassCreateController()
        let rect = CGRectMake(0, 0, kScreenWidth*0.25, kScreenHeight*0.25)
//        controller.preferredContentSize = rect.size
//
//        let window = NSWindow.create(rect, controller: controller)
//        window.level = .statusBar
//        NSApp.mainWindow?.beginSheet(window, completionHandler: { (response) in
//            DDLog(response)
//        })
        NSWindow.showSheet(with: controller, size: rect.size) { (response) in
            DDLog(response)
        }
    }
}
