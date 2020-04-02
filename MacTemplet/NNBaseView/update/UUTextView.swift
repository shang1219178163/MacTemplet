//
//  NNTextView.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa


class UUTextView: NSTextView {

    lazy var scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.backgroundColor = NSColor.red
        scrollView.drawsBackground = false
        scrollView.hasHorizontalScroller = true
        scrollView.hasVerticalScroller = true
        scrollView.autohidesScrollers = true
        
        return scrollView
    }()
    
    var placeHolder: String?
    
    // MARK: -lifecycle
    override init(frame frameRect: NSRect, textContainer container: NSTextContainer?) {
        super.init(frame: frameRect, textContainer: container)
        
        setupUI()
    }
    
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
        if string == "" && self != window?.firstResponder {
            guard let placeHolder = placeHolder else { return }
            let attDic = [NSAttributedString.Key.foregroundColor: NSColor.gray]
            let attString = NSAttributedString(string: placeHolder, attributes: attDic)
            attString.draw(at: NSMakePoint(4, 0))
        }
    }
    
    override func resignFirstResponder() -> Bool {
        needsDisplay = true
        return super.resignFirstResponder()
    }
    
    // MARK: -funtions
    func setupUI() {
        scrollView.documentView = self
    }
    
}
