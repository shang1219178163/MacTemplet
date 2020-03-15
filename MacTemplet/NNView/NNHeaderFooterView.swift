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
        return textField
    }()
    
    lazy var textFieldDetail: NSTextField = {
        let textField = NSTextField()
        textField.alignment = .right
        return textField
    }()
    
    
    // MARK: -life cycle
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
        addSubview(textField)
        addSubview(textFieldDetail)
    }
    
    override func layout() {
        super.layout()
        
        if bounds.height <= 0 {
            return
        }
        textField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.left.equalToSuperview().offset(10);
            make.bottom.equalToSuperview().offset(0);
            make.width.equalToSuperview().multipliedBy(0.4)
            make.height.equalToSuperview();
        }
        
        textFieldDetail.snp.makeConstraints { (make) in
            make.top.bottom.right.equalTo(textField).offset(0);
            make.right.equalToSuperview().offset(-10);
        }
    }
    
}
