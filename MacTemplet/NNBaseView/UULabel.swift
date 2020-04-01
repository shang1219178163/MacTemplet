//
//  HHLabel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class HHLabel: NSTextField {

    // MARK: -lifecycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    // MARK: -funtions
    func setupUI() {
        autoresizingMask = [.width, .height]
        isBordered = false;  ///是否显示边框
        isEditable = false;
        drawsBackground = true;
        backgroundColor = NSColor.clear;

        font = NSFont.systemFont(ofSize: 15)
        textColor = NSColor.black;
    }
    
}

