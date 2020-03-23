//
//  NNHeaderFooterView.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/15.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SnapKit


class NNHeaderFooterView: NSView {

    
    lazy var textField: NSTextField = {
        let textField = NSTextField()
        textField.wantsLayer = true
        textField.backgroundColor = NSColor.clear
        textField.isEditable = false;
        textField.isBordered = false
        return textField
    }()
    
    lazy var textFieldDetail: NSTextField = {
        let textField = NSTextField()
        textField.alignment = .right
        textField.wantsLayer = true
        textField.backgroundColor = NSColor.clear
        textField.isEditable = false;
        textField.isBordered = false

        return textField
    }()
    
    
    // MARK: -life cycle
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        addSubview(textField)
        addSubview(textFieldDetail)
        
        addSubview(lineTop)
        addSubview(lineBottom)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func layout() {
        super.layout()

        if bounds.height <= 0 {
            return
        }
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.left.equalToSuperview().offset(10);
            make.width.equalToSuperview().multipliedBy(0.45)
            make.bottom.equalToSuperview().offset(0);
        }

        textFieldDetail.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(textField).offset(0);
            make.right.equalToSuperview().offset(0);
        }
        
        lineTop.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.height.equalTo(1);
        }
        
        lineBottom.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(0);
            make.bottom.equalToSuperview().offset(0);
            make.height.equalTo(1);
        }
        
    }
    
}
