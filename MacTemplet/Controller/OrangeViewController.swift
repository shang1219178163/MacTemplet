//
//  OrangeViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/4.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class OrangeViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.layer?.backgroundColor = NSColor.lightOrange.cgColor

    }
    
    override func mouseDown(with event: NSEvent) {
        if presentedViewControllers?.last?.isEqual(self) == true {
            return
        }
        dismiss(self)
    }
}

