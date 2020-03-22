//
//  NNCollectionViewItem.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/15.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNCollectionViewItem: NSCollectionViewItem {
    
    lazy var textLabel: NSTextField = {
        let textField = NSTextField()
        textField.isEditable = false
        return textField
    }()
    
    lazy var textLabelBottom: NSTextField = {
        let textField = NSTextField()
        textField.isEditable = false
        return textField
    }()
    
    lazy var imgView: NSImageView = {
        let view = NSImageView()
        return view
    }()
    
    lazy var btn: NSButton = {
        let view = NSButton(title: "按钮", target: nil, action: nil)
        view.addActionHandler({ (control) in
            print(control)
        })
        return view
    }()
    
    override var isSelected: Bool {
      didSet {
        view.layer?.borderWidth = isSelected ? 3.0 : 0.0
      }
    }
    // MARK: -life cycle
    override func viewDidLoad() {
      super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.layer?.borderColor = NSColor.red.cgColor
        view.layer?.borderWidth = 0.0
        
        view.addSubview(imgView)
        view.addSubview(textLabel)
        view.addSubview(textLabelBottom)
        view.addSubview(btn)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        if view.bounds.height <= 0 {
            return
        }
        
        if textLabel.isHidden == true && textLabelBottom.isHidden == false {
            textLabelBottom.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(0);
                make.bottom.equalToSuperview().offset(0);
                make.height.equalTo(25);
            }
            
            imgView.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(0);
                make.left.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(0);
                make.bottom.equalTo(textLabelBottom.snp.top).offset(0);
            }
        } else if textLabelBottom.isHidden == true && textLabel.isHidden == false  {
            textLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(0);
                make.left.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(0);
                make.height.equalTo(25);
            }
            
            imgView.snp.makeConstraints { (make) in
                make.top.equalTo(textLabel.snp.bottom).offset(0);
                make.left.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(0);
                make.bottom.equalToSuperview().offset(0);
            }
        } else {
            textLabel.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(0);
                make.left.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(0);
                make.height.equalTo(25);
            }
            
            textLabelBottom.snp.makeConstraints { (make) in
                make.left.right.height.equalTo(textLabel);
                make.bottom.equalToSuperview().offset(0);
            }
            
            imgView.snp.makeConstraints { (make) in
                make.top.equalTo(textLabel.snp.bottom).offset(0);
                make.left.equalToSuperview().offset(0);
                make.right.equalToSuperview().offset(0);
                make.bottom.equalTo(textLabelBottom.snp.top).offset(0);
            }
        }
        
        btn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.5)
        }
    }
}
