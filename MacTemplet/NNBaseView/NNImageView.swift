//
//  NNImageView.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/3.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

@objcMembers class NNImageView: NSImageView {
    
    var backgroundColor = NSColor.clear{
        didSet{
            setNeedsDisplay()
        }
    }
    
    
    // MARK: -lifecycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
//        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        backgroundColor.set()
        NSBezierPath.fill(dirtyRect)
        
        if image != nil {
            image!.draw(in: dirtyRect)
        }
    }
    
    override func layout() {
        super.layout()
 
    }
    
    // MARK: -funtions
    func setupUI() {
        
    }
    
}
