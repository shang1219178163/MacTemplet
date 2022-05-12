//
//  KababCaseToCamelCase.swift
//  MacTemplet
//
//  Created by shangbinbin on 2022/5/12.
//  Copyright © 2022 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

import RxSwift
import RxCocoa

@objcMembers class KababCaseToCamelCase: NSViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = "";
        
        return view
    }()

    lazy var textViewOne: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = ""
        
        return view
    }()
    
    lazy var textField: NNTextField = {
        let view = NNTextField.create(.zero, placeholder: "忽略字符串")
        view.isBordered = true
        ///是否显示边框
        view.font = NSFont.systemFont(ofSize: 13)
        view.alignment = .center
        view.isTextAlignmentVerticalCenter = true
        view.maximumNumberOfLines = 1
        view.usesSingleLineMode = true
        view.tag = 100

        return view
    }()
    
    
    lazy var textFieldOne: NNTextField = {
        let view = NNTextField.create(.zero, placeholder: "class")
        view.isBordered = true
        ///是否显示边框
        view.font = NSFont.systemFont(ofSize: 13)
        view.alignment = .center
        view.isTextAlignmentVerticalCenter = true
        view.maximumNumberOfLines = 1
        view.usesSingleLineMode = true
        view.tag = 100

        return view
    }()
    
    lazy var textFieldTwo: NNTextField = {
        let view = NNTextField.create(.zero, placeholder: "var Suffix")
        view.isBordered = true
        ///是否显示边框
        view.font = NSFont.systemFont(ofSize: 13)
        view.alignment = .center
        view.isTextAlignmentVerticalCenter = true
        view.maximumNumberOfLines = 1
        view.usesSingleLineMode = true
        view.tag = 100

        return view
    }()

    lazy var btn: NSButton = {
        let view: NSButton = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .rounded
        view.title = "Done"

        view.addActionHandler { (sender) in
            NSApp.keyWindow!.makeFirstResponder(nil)
        }
        return view
    }()
    
    lazy var btnRefresh: NSButton = {
        let view: NSButton = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.bezelStyle = .rounded
        view.title = "刷新一下"

        view.addActionHandler { (sender) in
            NSApp.keyWindow!.makeFirstResponder(nil)
            self.convertContent()
        }
        return view
    }()
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(textView.enclosingScrollView!)
        view.addSubview(textViewOne.enclosingScrollView!)
        view.addSubview(textField)
        view.addSubview(textFieldOne)
        view.addSubview(textFieldTwo)
        view.addSubview(btn)
        view.addSubview(btnRefresh)

        NoodleLineNumberView.setupLineNumber(with: textView)
        
        textView.rxDrive { (value) in
            self.convertContent()
        }.disposed(by: disposeBag)
        
        textField.rxDrive { (value) in
            self.convertContent()
        }.disposed(by: disposeBag)
        
        textFieldOne.rxDrive { (value) in
            self.convertContent()
        }.disposed(by: disposeBag)
        
        
        textField.stringValue = "--van"
        textFieldOne.stringValue = ""
        textFieldTwo.stringValue = ""

        textView.string =
"""
--van-tab-text-color    var(--van-gray-7)    -
--van-tab-active-text-color    var(--van-text-color)    -
--van-tab-disabled-text-color    var(--van-text-color-3)    -
--van-tab-font-size    var(--van-font-size-md)    -
--van-tab-line-height    var(--van-line-height-md)    -
--van-tabs-default-color    var(--van-danger-color)    -
--van-tabs-line-height    44px    -
--van-tabs-card-height    30px    -
--van-tabs-nav-background-color    var(--van-background-color-light)    -
--van-tabs-bottom-bar-width    40px    -
--van-tabs-bottom-bar-height    3px    -
--van-tabs-bottom-bar-color    var(--van-danger-color)    -

"""
//        setupDefaultContent()
//        convertContent()
        
        textFieldOne.isHidden = true
        textFieldTwo.isHidden = true
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let items = [textView.enclosingScrollView!, textViewOne.enclosingScrollView!]
        items.snp.distributeViewsAlong(axisType: .horizontal, fixedSpacing: 15, leadSpacing: 0, tailSpacing: 0)
        items.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0);
            make.bottom.equalToSuperview().offset(-45);
        }
        
        btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-kPadding)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        btnRefresh.snp.makeConstraints { (make) in
            make.right.equalTo(btn.snp.left).offset(-10)
            make.bottom.width.height.equalTo(btn)
        }
                
        textField.snp.remakeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10);
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
        
        textFieldOne.snp.remakeConstraints { (make) in
            make.left.equalTo(textField.snp.right).offset(10)
            make.bottom.width.height.equalTo(textField)
        }

        textFieldTwo.snp.remakeConstraints { (make) in
            make.left.equalTo(textFieldOne.snp.right).offset(10)
            make.bottom.width.height.equalTo(textField)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    
    }
    // MARK: -funtions
    func convertContent() {
        let validStr = self.textField.stringValue;

        let list = textView.string
            .split(separator: "\n")
            .map { e -> String in
                let array = e.split(separator: " ");
                let key = array[0].replacingOccurrences(of: validStr, with: "");
                return "\(key.toCamelCase().firstLetterLowercased()): \(array[1]),"
            }
        textViewOne.string = list.joined(separator: "\n")
    }
    

}

//public extension String{
//    func toCamelCase() -> String {
//        let result = self.split(separator: "-").reduce("", { $0 + $1.capitalized })
//        return result;
//    }
//    
//    func firstLetterLowercased() -> String {
//        let result = self[0].lowercased() + self[1...];
//        return result;
//    }
//}
//
//
//public extension Substring{
//    func toCamelCase() -> String {
//        return String(self).toCamelCase()
//    }
//
//    func firstLetterLowercased() -> String {
//        return String(self).firstLetterLowercased()
//    }
//}
