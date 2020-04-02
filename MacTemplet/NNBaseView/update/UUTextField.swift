//
//  UUTextField.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class UUTextField: NSTextField {

    var isTextAlignmentVerticalCenter = false{
        willSet{
            (cell as! UUTextFieldCell).isTextAlignmentVerticalCenter = newValue
        }
    }

    // MARK: -life cycle
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
        cell = UUTextFieldCell(textCell: "")
        isEditable = true
    }
    
    
}
