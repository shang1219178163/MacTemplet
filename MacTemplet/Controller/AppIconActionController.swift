//
//  AppIconActionController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/29.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class AppIconActionController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: -funtions
// 关闭应用
    @objc func closeApp(_ sender: Any) {
        /** NSApplictiaon的单利可以简写为NSApp*/
        NSApplication.shared.terminate(nil)
    }
    
    /**显示App的数字提醒*/
    @objc func showAppNumber(_ sender: Any) {
        NSApp.dockTile.badgeLabel = "20"
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
