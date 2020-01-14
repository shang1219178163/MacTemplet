//
//  BatchClassCreateController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import SnapKit
import SnapKitExtend

class BatchClassCreateController: NSViewController {
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = ""
        view.delegate = self
        return view;
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = ["UIViewController文件", "自定义UIView文件", "API文件", "ViewModel文件",]

        return view;
    }()
    
    lazy var btnPopCategory: NSPopUpButton = {
        let view = NSPopUpButton(frame: .zero, pullsDown: false)
        view.autoenablesItems = false
        
        let list = ["list", "detail"]
        view.addItems(withTitles: list)
        view.addActionHandler { (control) in
            NSApp.mainWindow?.makeFirstResponder(nil)
//            let sender: NSPopUpButton = control as! NSPopUpButton;
//            DDLog(sender.titleOfSelectedItem)
            self.batchCreateFile(self.textView.string)

        }
        return view;
    }()
    
    lazy var btnPop: NSPopUpButton = {
        let view = NSPopUpButton(frame: .zero, pullsDown: false)
        view.autoenablesItems = false
        
        let list = ["Swift", "ObjC",]
        view.addItems(withTitles: list)
        view.addActionHandler { (control) in
            NSApp.mainWindow?.makeFirstResponder(nil)
//            let sender: NSPopUpButton = control as! NSPopUpButton;
//            DDLog(sender.titleOfSelectedItem)
            self.batchCreateFile(self.textView.string)

        }
        return view;
    }()

    lazy var btn: NSButton = {
        let view = NSButton(title: "Done", target: nil, action: nil)
        view.setButtonType(.momentaryPushIn)
        view.bezelStyle = .rounded
//        view.bezelColor = NSColor.blue.withAlphaComponent(0.5)
        view.addActionHandler { (control) in
            NSApp.mainWindow?.makeFirstResponder(nil)
            self.batchCreateFile(self.textView.string)

        }
        return view;
    }()
    
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        title = "iOS类文件批量生成"
        view.addSubview(btn)
        view.addSubview(btnPop)
        view.addSubview(btnPopCategory)
        view.addSubview(segmentCtl)
        view.addSubview(textView.enclosingScrollView!)
        
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
                
        btn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(80)
        }
        
        btnPop.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalTo(btn.snp.left).offset(-10)
            make.height.equalTo(btn)
            make.width.equalTo(btn)
        }
                
        btnPopCategory.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.right.equalTo(btnPop.snp.left).offset(-10)
            make.height.equalTo(btn)
            make.width.equalTo(btn)
        }
        
        let width = CGFloat(segmentCtl.items.count)*120
        segmentCtl.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(width)
        }
        
        textView.enclosingScrollView!.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalTo(btn.snp.top).offset(-10)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        return;
        
        DDLog(NSApplication.getCopyright(with: "IOPParkListController", type: "swift"))
        
        let result = NNViewControllerCreater.getContent(with: "IOPParkListController", type: "swift")
        FileManager.createFile(content: result, name: "IOPParkListController", type: "swift", isCover: true, openDir: true)
        
        let resultAPI = NNRequestAPICreater.getContent(with: "IOPSaasRegisterApi", type: "swift")
        FileManager.createFile(content: resultAPI, name: "IOPSaasRegisterApi", type: "swift", isCover: true, openDir: true)
        
        var name = "IOPParkListController"
        name = "IOPParkListViewController"
//        if name.contains("ViewController") {
//            name = name.components(separatedBy: "ViewController").first!
//        } else if name.contains("Controller")  {
//            name = name.components(separatedBy: "Controller").first!
//        }
        
        let prefix = name.getPrefix(with: ["ViewController", "Controller"])
        DDLog(prefix)
        DDLog(NSApplication.classCopyright)

    }
    
    // MARK: -funcitons
    /// 批量创建文件
    func batchCreateFile(_ string: String) {
        if string.count <= 0 {
            return
        }
        createFiles(string, idx: segmentCtl.selectedSegment, type: btnPop.titleOfSelectedItem!.lowercased())
    }
    /// 按照类型创建文件
    func createFiles(_ string: String, idx: Int, type: String = "swift") {
        if string.count <= 0 {
            return
        }
        
        let separate = string.contains(",") ? "," : "\n"
        let titles = string.components(separatedBy: separate)
        var result = ""

        for e in titles.enumerated() {
            switch idx {
            case 1: // 创建自定义视图
                if !e.element.hasSuffix("View") {
                    _ = NSAlert.show("错误", msg: "自定义视图必须包含 View 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                    return
                }
                
                if type == "swift" {
                    result = NNViewCreater.getContent(with: e.element, type: type)
                    FileManager.createFile(content: result, name: e.element, type: type, isCover: true, openDir: true)
                    break
                }
                
            case 2: // 创建 API 类
                if !e.element.hasSuffix("API") && !e.element.hasSuffix("Api") {
                    _ = NSAlert.show("错误", msg: "API文件必须包含 Api 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                    return
                }
                
                if type == "swift" {
                    result = NNRequestAPICreater.getContent(with: e.element, type: type)
                    FileManager.createFile(content: result, name: e.element, type: type, isCover: true, openDir: true)
                    break
                }

            case 3: //
                createViewModelFiles(e.element, btnPop: btnPopCategory, type: type)
                
            default: // 创建 UIViewController 文件
                createControllerFiles(e.element, btnPop: btnPopCategory, type: type)
            }
        }
    }
    
    /// 生成UIViewController类型文件
    func createControllerFiles(_ string: String, btnPop: NSPopUpButton, type: String = "swift") {
        if !string.hasSuffix("Controller") {
            _ = NSAlert.show("错误", msg: "页面必须包含 Controller 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
            return
        }
        
        var result = ""
//        var resultM = ""
        
        switch btnPop.titleOfSelectedItem {
        case btnPop.itemTitles[1]:
            if type == "swift" {
                result = NNViewControllerDetailCreater.getContent(with: string, type: type)
                FileManager.createFile(content: result, name: string, type: type, isCover: true, openDir: true)
                
            } else if type == "objc"  {
//                result = NNViewControllerDetailCreater.getContentH(with: string)
//                resultM = NNViewControllerDetailCreater.getContentM(with: string)
//                FileManager.createFile(content: result, name: string, type: "h", isCover: true, openDir: true)
//                FileManager.createFile(content: resultM, name: string, type: "m", isCover: true, openDir: true)
            }
            
        default:
            if type == "swift" {
                result = NNViewControllerCreater.getContent(with: string, type: type)
                FileManager.createFile(content: result, name: string, type: type, isCover: true, openDir: true)
                
            } else if type == "objc"  {
//                result = NNViewControllerCreater.getContentH(with: string)
//                resultM = NNViewControllerCreater.getContentM(with: string)
//                FileManager.createFile(content: result, name: string, type: "h", isCover: true, openDir: true)
//                FileManager.createFile(content: resultM, name: string, type: "m", isCover: true, openDir: true)
            }
        }
    }
    
    /// 生成ViewModel类型文件
    func createViewModelFiles(_ string: String, btnPop: NSPopUpButton, type: String = "swift") {
        if !string.hasSuffix("ViewModel") {
            _ = NSAlert.show("错误", msg: "RequestViewModel文件必须包含 ViewModel 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
            return
        }
        
        var result = ""
        var resultM = ""
        
        switch btnPop.titleOfSelectedItem {
        case btnPop.itemTitles[1]:
            if type == "swift" {
                result = NNRequestViewCreaterDetail.getContent(with: string, type: type)
                FileManager.createFile(content: result, name: string, type: type, isCover: true, openDir: true)
                
            } else if type == "objc"  {
                result = NNRequestViewCreaterDetail.getContentH(with: string)
                resultM = NNRequestViewCreaterDetail.getContentM(with: string)
                FileManager.createFile(content: result, name: string, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: string, type: "m", isCover: true, openDir: true)
            }
            
        default:
            if type == "swift" {
                result = NNRequestViewCreater.getContent(with: string, type: type)
                FileManager.createFile(content: result, name: string, type: type, isCover: true, openDir: true)
                
            } else if type == "objc"  {
                result = NNRequestViewCreater.getContentH(with: string)
                resultM = NNRequestViewCreater.getContentM(with: string)
                FileManager.createFile(content: result, name: string, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: string, type: "m", isCover: true, openDir: true)
            }
        }
    }
}

extension BatchClassCreateController: NSTextViewDelegate {

    func textShouldBeginEditing(_ textObject: NSText) -> Bool{
        return true
    }

    func textShouldEndEditing(_ textObject: NSText) -> Bool {
        return true
    }
    
    func textDidBeginEditing(_ notification: Notification){
        
    }

    func textDidEndEditing(_ notification: Notification){
        
    }

    func textDidChange(_ notification: Notification) {
        batchCreateFile(textView.string)
    }
}
