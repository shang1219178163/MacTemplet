//
//  NNUserInfoView.swift
//  Swift-NSToolBar
//
//  Created by Bin Shang on 2020/3/31.
//  Copyright © 2020 Knowstack. All rights reserved.
//

import Cocoa

import CocoaExpand

@objc protocol NNUserInfoViewDelegate: NSObjectProtocol {
    @objc func userInfoView(_ userView: NNUserInfoView, state: NSResponder.MouseState, event: NSEvent);
}

class NNUserInfoView: NSView {
    
    weak var delegate: NNUserInfoViewDelegate?
    
    var image = NSImage(named: "img_portrait_N")
    
    var name = "姓名"
    var desc = "个人简介"
    
    // MARK: -life cycle
    override var isFlipped: Bool{
        return true
    }

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addTrackingRect(bounds, owner: self, userData: nil, assumeInside: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        let imageRect = NSRect(x: 0, y: 0, width: bounds.height, height: bounds.height)
        image?.draw(in: imageRect)
        
        
        let paraStyle: NSMutableParagraphStyle = NSMutableParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paraStyle.alignment = .left
        paraStyle.lineBreakMode = .byWordWrapping
        
        let attDic = [NSAttributedString.Key.paragraphStyle: paraStyle,
                      NSAttributedString.Key.foregroundColor: NSColor.labelColor,
                      NSAttributedString.Key.font: NSFont.systemFont(ofSize: 13, weight: .light)
        ]
        
        let attString = NSAttributedString(string: name, attributes: attDic)
        let nameRect = NSRect(x: bounds.height + 3, y: 0, width: bounds.width - bounds.height - 3, height: bounds.height*0.5)
        attString.draw(in: nameRect)
        
        let attStringSub = NSAttributedString(string: desc, attributes: attDic)
        let descRect = NSRect(x: bounds.height + 3, y: bounds.height*0.5, width: bounds.width - bounds.height - 3, height: bounds.height*0.5)
        attStringSub.draw(in: descRect)
    }
    
    // MARK: -mouse
    override func mouseEntered(with event: NSEvent) {
//        print("\(#function):\(event)")
        delegate?.userInfoView(self, state: NSResponder.MouseState.entered, event: event)
    }
    
    override func mouseExited(with event: NSEvent) {
//        print("\(#function):\(event)")
        delegate?.userInfoView(self, state: NSResponder.MouseState.exited, event: event)
    }
    
    override func mouseDown(with event: NSEvent) {
//        print("\(#function):\(event)")
        delegate?.userInfoView(self, state: NSResponder.MouseState.down, event: event)
    }
    
    override func mouseUp(with event: NSEvent) {
//        print("\(#function):\(event)")
        delegate?.userInfoView(self, state: NSResponder.MouseState.up, event: event)        
    }
    
}
