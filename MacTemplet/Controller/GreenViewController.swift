//
//  GreenViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/4.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class GreenViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.layer?.backgroundColor = NSColor.lightGreen.cgColor

    }
    
    override func mouseDown(with event: NSEvent) {
        if presentingViewController == nil {
            return
        }
        dismiss(self)
    }
}
