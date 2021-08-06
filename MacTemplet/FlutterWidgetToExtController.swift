//
//  FlutterWidgetToExtController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/5/15.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand
import WebKit

import RxSwift
import RxCocoa
import Then

@objcMembers class FlutterWidgetToExtController: NSViewController {
    
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
        let view = NNTextField.create(.zero, placeholder: "var Prefix")
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
            self.createFiles()
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
    
    
    var propertyPrefix = "to"
    var propertySuffix = ""

    var propertyClass = "Widget_extension"

    var hContent = ""

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
            self.propertyPrefix = value
            self.convertContent()
        }.disposed(by: disposeBag)
        
        textFieldOne.rxDrive { (value) in
            self.propertyClass = value
            self.convertContent()
        }.disposed(by: disposeBag)
        
        textFieldTwo.isHidden = true
        
        textField.stringValue = propertyPrefix
        textFieldOne.stringValue = propertyClass
        textFieldTwo.stringValue = propertySuffix

        textView.string = kContainerContent
        
        
        let list = NSArray.generate(count: 9) { (index) -> NSArray.Element in
            return "item\(index)"
        }
        DDLog(list)
        let style = NSMutableParagraphStyle()
            .lineSpacingChain(2)
            .paragraphSpacingChain(2)
            .paragraphSpacingBeforeChain(10)
        
    
        
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
//            make.top.equalTo(textField).offset(5)
            make.right.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-kPadding)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        btnRefresh.snp.makeConstraints { (make) in
//            make.top.equalTo(textField).offset(5)
            make.right.equalTo(btn.snp.left).offset(-10)
            make.bottom.width.height.equalTo(btn)
        }
                
        textField.snp.remakeConstraints { (make) in
//            make.top.equalTo(textView.snp.bottom).offset(kPadding)
            make.left.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(-10);
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
        
        textFieldOne.snp.remakeConstraints { (make) in
//            make.top.equalTo(textView.snp.bottom).offset(kPadding)
            make.left.equalTo(textField.snp.right).offset(10)
            make.bottom.width.height.equalTo(textField)
        }

        textFieldTwo.snp.remakeConstraints { (make) in
//            make.top.equalTo(textView.snp.bottom).offset(kPadding)
            make.left.equalTo(textFieldOne.snp.right).offset(10)
            make.bottom.width.height.equalTo(textField)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    
    }
    // MARK: -funtions
    func convertContent() {
        propertyPrefix = textField.stringValue
        propertySuffix = textFieldTwo.stringValue
        

        let text = textView.string
        let lines = text.components(separatedBy: "\n")
            .filter({ $0.trimmed != "" })
            .map { $0.trimmed }
        
        propertyClass = lines.filter({ $0.hasSuffix("({") }).first!.replacingOccurrences(of: "({", with: "")
        
        let pnames = lines
            .map({ (e) -> String in
                var result = "";
                if e.hasPrefix("Key? key,") {
                    result = "key";
                } else if e.hasPrefix("this.") {
                    if e.contains("=") {
                        result = String(e.split(separator: "=").first!).trimmed
                        result = String(result.split(separator: ".").last!).trimmed
                    } else {
                        result = String(e.split(separator: ".").last!).trimmed
                    }
                } else if e.contains(" ") {
                    result = String(e.split(separator: " ").last!)
                }
                return result.replacingOccurrences(of: ",", with: "")
            })
            .filter { !$0.hasSuffix("({") && !$0.hasPrefix("})") && $0.trimmed != ""}

        ;
//        DDLog(pnames);
        
        var tmp = ""
        pnames
            .filter({ $0 != "child" })
            .forEach { (e) in
            if e == "key" {
                tmp += "\(e.capitalized)? \(e)," + "\n"
            } else {
                tmp += "\(e)," + "\n"
            }
        }
        
        var tmp1 = ""
        pnames.forEach { (e) in
            if e == "child" {
                tmp1 += "\(e): this," + "\n"
            } else {
                tmp1 += "\(e): \(e)," + "\n"
            }
        }
        
        let content = """
\(propertyClass) \(propertyPrefix)\(propertyClass)({
  \(tmp)
}) => \(propertyClass)(
  \(tmp1)
);
"""

        textViewOne.string =
"""
extension WidgetExt on Widget {
\(content)
}
"""
    }
    
    func createFiles() {
        if hContent == "" {
            convertContent()
        }
        FileManager.createFile(content: textViewOne.string, name: "\(textFieldOne.stringValue)", type: "dart")
    }
    
}


let kContainerContent = """
Container({
  Key? key,
  this.alignment,
  this.padding,
  this.color,
  this.decoration,
  this.foregroundDecoration,
  double? width,
  double? height,
  BoxConstraints? constraints,
  this.margin,
  this.transform,
  this.transformAlignment,
  this.child,
  this.clipBehavior = Clip.none,
})
"""

