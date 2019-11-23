//
//  NSTextView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSTextView {
    
    override func performKeyEquivalent(with event: NSEvent) -> Bool {
        if event.modifierFlags.isDisjoint(with: .command) {
            return super.performKeyEquivalent(with: event)
        }
        
        switch event.charactersIgnoringModifiers {
        case "a":
            return NSApp.sendAction(#selector(NSText.selectAll(_:)), to: self.window?.firstResponder, from: self)
        case "c":
            return NSApp.sendAction(#selector(NSText.copy(_:)), to: self.window?.firstResponder, from: self)
        case "v":
            return NSApp.sendAction(#selector(NSText.paste(_:)), to: self.window?.firstResponder, from: self)
        case "x":
            return NSApp.sendAction(#selector(NSText.cut(_:)), to: self.window?.firstResponder, from: self)
        case "z":
            self.window?.firstResponder?.undoManager?.undo()
            return true
        case "Z":
            self.window?.firstResponder?.undoManager?.redo()
            return true
        default:
            return super.performKeyEquivalent(with: event)
        }
    }
    
    static func create(_ rect: CGRect) -> Self {
        let view: NSTextView = self.init(frame: rect);
        view.autoresizingMask = [.width, .height];
           
        view.font = NSFont.systemFont(ofSize: 14)
        view.textColor = NSColor.black;

        view.isHorizontallyResizable = false;
        view.isVerticallyResizable = true;

        view.maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        view.isSelectable = true;
        view.drawsBackground = true

        return view as! Self;
    }
    
    /// 超链接处理
    /// - Parameter dic: [标题:网址]
    func hyperlink(dic: [String : String]) {
        let mattStr = NSAttributedString.hyperlink(dic: dic, text: self.string, font: self.font!)
        self.textStorage?.setAttributedString(mattStr)
        self.isEditable = false;
        self.isSelectable = true;
    }
    
}
