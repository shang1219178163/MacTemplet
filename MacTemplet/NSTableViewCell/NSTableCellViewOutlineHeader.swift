//
//  NSTableCellViewOutlineHeader.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/9.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import SnapKit

class NSTableCellViewOutlineHeader: NSTableCellView {
    
    lazy var imgView: NSImageView = {
        let view = NSImageView()
        return view
    }()
    
    lazy var button: NSButton = {
        let view = NSButton(title: "", target: nil, action: nil)
//        view.setButtonType(.momentaryPushIn)
        view.wantsLayer = true;
        view.bezelStyle = .texturedSquare
        view.isBordered = false
        view.alignment = .left
//        view.bezelColor = NSColor.blue.withAlphaComponent(0.5)
        view.addActionHandler { (control) in
            DDLog(control)
            
        }
        return view;
    }()
    
    lazy var detailButton: NSButton = {
        let view = NSButton(title: "", target: nil, action: nil)
//        view.setButtonType(.momentaryPushIn)
        view.wantsLayer = true;
        view.bezelStyle = .texturedSquare
        view.isBordered = false
//        view.bezelColor = NSColor.blue.withAlphaComponent(0.5)
        view.addActionHandler { (control) in
            DDLog(control)
            
        }
        return view;
    }()
    
    var btnSizeToFit = false
    
    // MARK: -lifecycle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        addSubview(imgView)
        addSubview(button)
        addSubview(detailButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layout() {
//        super.layout()
//        
//
//    }
        
    override func viewWillDraw() {
        super.viewWillDraw()

        if imgView.isHidden == true {
            if detailButton.isHidden == true {
                button.snp.remakeConstraints { (make) in
                    make.centerY.equalToSuperview().offset(0);
                    make.left.equalToSuperview().offset(10);
                    make.right.equalToSuperview().offset(-10);
                    make.height.equalToSuperview()
                }
                return
            }
            
            detailButton.sizeToFit()
            detailButton.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(-10);
            }

            button.snp.remakeConstraints { (make) in
                make.centerY.equalToSuperview().offset(0);
                make.left.equalToSuperview().offset(10);
                make.right.equalTo(detailButton.snp.left).offset(-5);
                make.height.equalToSuperview()
            }
            return
        }
        
        detailButton.sizeToFit()
        detailButton.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0);
            make.right.equalToSuperview().offset(-10);
        }
        
        imgView.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(NSHeight(bounds) - 10)
        }
        
        button.snp.remakeConstraints { (make) in
            make.centerY.equalToSuperview().offset(0)
            make.left.equalTo(imgView.snp.right).offset(5)
            make.right.equalTo(detailButton.snp.left).offset(-5)
            make.height.equalTo(imgView)
        }
    }
    
}
