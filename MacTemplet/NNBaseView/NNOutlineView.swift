//
//  NNOutlineView.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNOutlineView: NSOutlineView {
    
    lazy var scrollView: NSScrollView = {
        let view = NSScrollView()
        view.backgroundColor = .white
        view.drawsBackground = false
        view.hasHorizontalScroller = true
        view.hasVerticalScroller = true
        view.autohidesScrollers = true
        
        return view
    }()
    
    var adjustsTableColumnsWidth = true

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
    
    override func layout() {
        super.layout()
        
        if adjustsTableColumnsWidth == true {
            for column in tableColumns {
                column.width = scrollView.bounds.width/CGFloat(tableColumns.count);
            }
        }
    }
    
    // MARK: -funtions
    func setupUI() {
        scrollView.documentView = self
    }
    
}
