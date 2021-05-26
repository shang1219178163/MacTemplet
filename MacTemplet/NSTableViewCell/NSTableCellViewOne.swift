//
//  NSTableCellViewOne.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/12/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand
import SnapKit

class NSTableCellViewOne: NSTableCellView {
    
    lazy var imgView: NSImageView = {
        let view = NSImageView()
        return view
    }()

    lazy var label: NSTextField = {
        let view = NSTextField(frame: .zero)
        view.isBordered = false;  ///是否显示边框
        view.wantsLayer = true;
        view.isEditable = false;
        view.drawsBackground = true;
        view.backgroundColor = NSColor.clear
        
        view.usesSingleLineMode = true
        view.lineBreakMode = .byWordWrapping

        view.stringValue = "标题显示"

        return view;
    }()
    
    lazy var button: NSButton = {
        let view = NSButton(title: "", target: nil, action: nil)
//        view.setButtonType(.momentaryPushIn)
        view.bezelStyle = .inline
//        view.bezelColor = NSColor.blue.withAlphaComponent(0.5)
        view.addActionHandler { (control) in
            DDLog(control)
            
        }
        return view;
    }()
    
    // MARK: -lifecycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        addSubview(imgView)
        addSubview(label)
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillDraw() {
        super.viewWillDraw()

        if imgView.isHidden == true {
            if button.isHidden == true {
                label.snp.makeConstraints { (make) in
                    make.centerY.equalToSuperview().offset(0);
                    make.left.equalToSuperview().offset(10);
                    make.right.equalToSuperview().offset(-10);
                    make.height.equalTo(button);
                }
                return
            }
            
            button.sizeToFit()
            button.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(-10);
            }

            label.snp.makeConstraints { (make) in
                make.centerY.equalToSuperview().offset(0);
                make.left.equalToSuperview().offset(10);
                make.right.equalTo(button.snp.left).offset(-5);
                make.height.equalTo(button);
            }
            return
        }

        button.sizeToFit()
        button.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0)
            make.right.equalToSuperview().offset(-15)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(NSHeight(bounds) - 10)
        }
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0)
            make.left.equalTo(imgView.snp.right).offset(5)
            make.right.equalTo(button.snp.left).offset(-5)
            make.height.equalTo(imgView)
        }
    }
    
    
}
