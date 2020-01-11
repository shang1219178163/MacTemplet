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
        view.items = ["UIViewController列表", "自定义视图", "API文件", ]
        return view;
    }()

    lazy var btn: NSButton = {
        let view = NSButton(title: "Done", target: nil, action: nil)
        view.setButtonType(.momentaryPushIn)
        view.bezelStyle = .shadowlessSquare
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
        view.addSubview(segmentCtl)
        view.addSubview(textView.enclosingScrollView!)
        
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
                
        btn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
        let width = CGFloat(segmentCtl.items.count)*120
        segmentCtl.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(50)
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
        
        let result = NNViewControllerModel.getContent(with: "IOPParkListController", type: "swift")
        FileManager.createFile(content: result, name: "IOPParkListController", type: "swift", isCover: true, openDir: true)
        
        let resultAPI = NNRequestAPIModel.getContent(with: "IOPSaasRegisterApi", type: "swift")
        FileManager.createFile(content: resultAPI, name: "IOPSaasRegisterApi", type: "swift", isCover: true, openDir: true)
        
        var name = "IOPParkListController"
        name = "IOPParkListViewController"
//        if name.contains("ViewController") {
//            name = name.components(separatedBy: "ViewController").first!
//        } else if name.contains("Controller")  {
//            name = name.components(separatedBy: "Controller").first!
//        }
        DDLog(NNViewControllerModel.getPrefix(with: name))
        DDLog(NSApplication.classCopyright)

    }
    
    // MARK: -funcitons
    /// 批量创建文件
    func batchCreateFile(_ string: String) {
        if string.count <= 0 {
            return
        }
        createFiles(string, idx: segmentCtl.selectedSegment)
    }
    /// 按照类型创建文件
    func createFiles(_ string: String, type: String = "swift", idx: Int) {
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
                result = NNViewModel.getContent(with: e.element, type: type)

            case 2: // 创建 API 类
                if !e.element.hasSuffix("API") && !e.element.hasSuffix("Api") {
                      _ = NSAlert.show("错误", msg: "API文件必须包含 Api 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                      return
                  }
                result = NNRequestAPIModel.getContent(with: e.element, type: type)

            default: // 创建 UIViewController 文件
                if !e.element.hasSuffix("Controller") {
                    _ = NSAlert.show("错误", msg: "页面必须包含 Controller 后缀", btnTitles: [kTitleSure], window: NSApp.keyWindow!)
                    return
                }
                result = NNViewControllerModel.getContent(with: e.element, type: type)
            }
            FileManager.createFile(content: result, name: e.element, type: type, isCover: true, openDir: true)
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
        if textView.string.count <= 0 {
            return
        }
        batchCreateFile(textView.string)
    }
}
