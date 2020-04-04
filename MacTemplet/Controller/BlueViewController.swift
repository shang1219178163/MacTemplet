//
//  BlueViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/4.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

class BlueViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    override func mouseDown(with event: NSEvent) {
        if presentingViewController == nil {
            return
        }
        dismiss(self)
    }
}
