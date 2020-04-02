//
//  AppIconActionController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/29.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

class AppIconActionController: NSViewController {

    var titleList: [String] = []

    var itemList: [NSButton] = []

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor

        // Do any additional setup after loading the view.
        let str: String = String(String(repeating: "Button,", count: 15).dropLast())
        let list: [String] = str.components(separatedBy: ",")
        
        itemList = NSButton.createGroupView(.zero, list: list, numberOfRow: 4, padding: 8, target: self, action: #selector(handleAction(_:)), inView: view);
        
//        DDLog(view.frame, view.bounds)
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.5)
        NSButton.setupConstraint(frame, items: itemList)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: -funtions
    @objc func handleAction(_ sender: NNButton) {
        DDLog("\(sender.tag)")

        switch sender.tag {
        case 0:
            closeApp(sender)
        case 1:
            showAppNumber(sender)
        case 2:
            jump(sender)
        case 3:
            hideDockIcon(sender)
        case 4:
            showDockIcon(sender)
        default:
            break
        }
    }
    
// 关闭应用
    @objc func closeApp(_ sender: Any) {
        /** NSApplictiaon的单利可以简写为NSApp*/
        NSApplication.shared.terminate(nil)
    }
    
    /**显示App的数字提醒*/
    @objc func showAppNumber(_ sender: Any) {
        NSApp.dockTile.badgeLabel = "20"
        
        let showBadge = (NSApp.dockTile.badgeLabel != "0" && NSApp.dockTile.badgeLabel != "")
        NSApp.dockTile.showsApplicationBadge = showBadge
    }
    
    /** 实现Dock 上的App 图标弹跳 */
    @objc func jump(_ sender: Any) {
        /**
          criticalRequest   // 多次跳动App Dock 上的图标,直到用户选中App为活动状态
          informationalRequest  // 一次跳动App Dock 上的图标
         */
        // 这个方法只能在当前App 不是处于非活动时才有效
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
            NSApp.requestUserAttention(.informationalRequest)
        }
    }
    
    // 隐藏Dock 上的App 图标
    @objc func hideDockIcon(_ sender: Any) {
        // 隐藏App 图标,会自动隐藏窗口
        NSApp.setActivationPolicy(.accessory)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            NSApp.unhideWithoutActivation()
        }
    }
    // 显示Dock 上的App 图标
    @objc func showDockIcon(_ sender: Any) {
         NSApp.setActivationPolicy(.regular)
    }
}
