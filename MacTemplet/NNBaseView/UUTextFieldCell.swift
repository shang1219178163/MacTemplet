//
//  UUTextFieldCell.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class UUTextFieldCell: NSTextFieldCell {

    var isTextAlignmentVerticalCenter = false
    
    
    // MARK: -overid
    override func edit(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, event: NSEvent?) {
        super.edit(withFrame: rect, in: controlView, editor: textObj, delegate: delegate, event: event)
    }
    
    override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        super.select(withFrame: rect, in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
    }
    
    override func drawInterior(withFrame cellFrame: NSRect, in controlView: NSView) {
        super.drawInterior(withFrame: cellFrame, in: controlView)
    }
    
    // MARK: -funtions
    func adjustedFrameToVerticallyCenter(_ rect: NSRect) -> NSRect {
        if isTextAlignmentVerticalCenter == false {
            return rect
        }
        guard let font = font else { return rect }
        let offset = floor(NSHeight(rect)/2 - (font.ascender + font.descender))
        return NSInsetRect(rect, 0, offset)
    }
}
