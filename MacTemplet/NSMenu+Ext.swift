//
//  NSMenu+Ext.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/8/6.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand


@objc public extension NSMenu {



}


class MenuDemoControler: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    
    @objc func handActionBtn(_ sender: NSMenuItem) {
        DDLog(sender)
    }
    
}
