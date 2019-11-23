//
//  NSTextField+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSTextField {
    
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
 
    static func create(_ rect: CGRect, placeholder: String) -> Self {
        let view: NSTextField = self.init(frame: rect);
        view.autoresizingMask = [.width, .height];
           
        view.font = NSFont.systemFont(ofSize: 15)
        view.textColor = NSColor.black;

        view.isBordered = false;  ///是否显示边框
        view.drawsBackground = true;

        view.cell!.wraps = false;
        view.cell!.isScrollable = true;
        view.placeholderString = placeholder;
        
        return view as! Self;
    }
    
    /// 超链接处理
    /// - Parameter dic: [标题:网址]
    func hyperlink(dic: [String : String]) {
        let mattStr = NSAttributedString.hyperlink(dic: dic, text: self.stringValue, font: self.font!)
        self.attributedStringValue = mattStr
        
        self.cell?.wraps = true;
        self.cell?.isScrollable = true;
        self.isEditable = false;
        self.isSelectable = true;
        self.allowsEditingTextAttributes = true;
    }
}
