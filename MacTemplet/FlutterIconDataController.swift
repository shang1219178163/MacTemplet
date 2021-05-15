//
//  FlutterIconDataController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/5/12.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

import RxSwift
import RxCocoa

@objcMembers class FlutterIconDataController: NSViewController {
    
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
            NSApp.mainWindow!.makeFirstResponder(nil)
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
            NSApp.mainWindow!.makeFirstResponder(nil)
            self.convertContent()
        }
        return view
    }()
    
    
    var propertyPrefix = ""
    var propertySuffix = ""

    var propertyClass = ""
    var propertyClassAvailableDes = ""

    var hContent = ""

    let lines = Bundle.readPath(forResource: "IconData", ofType: ".txt")!.filter { $0.contains("IconData ") }

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
        
        
        textField.stringValue = propertyPrefix
        textFieldOne.stringValue = propertyClass
        textFieldTwo.stringValue = propertySuffix

        textView.string = lines.joined(separator: "\n")
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
        
        var list = [String]()
        var dic = [String: String]()

        let text = textView.string
        let lines = text.components(separatedBy: "\n")
        lines.forEach { (e) in
            var tmp = e
            if e.contains(" get ") && e.contains(" => ") {
                tmp = e.trimmed.replacingOccurrences(of: " get ", with: " ")
                tmp = tmp.components(separatedBy: " => ").first ?? ""

            } else if e.contains("static const ") {
                tmp = e.trimmed.replacingOccurrences(of: "static const ", with: "")
                tmp = tmp.components(separatedBy: " = ").first ?? ""
            }
            tmp = tmp.trimmed.replacingOccurrences(of: " ", with: ".")
            
            list.append(tmp)
            dic[tmp] = tmp;
        }

        textViewOne.string =
"""
\(list.joined(separator: ",\n"))
"""
        
//        textViewOne.string =
//"""
//\(dic.jsonString)
//"""
        
        textField.stringValue = list.first!.components(separatedBy: ".").first!
    }
    
    func createFiles() {
        if hContent == "" {
            convertContent()
        }
        FileManager.createFile(content: textViewOne.string, name: "\(textFieldOne.stringValue)", type: "swift")
    }
    
}
