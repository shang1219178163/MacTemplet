//
//  NNBatchClassCreateController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/14.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import SnapKit
import SnapKitExtend

let kBatchTips = """
\nUIViewController 分为List(列表), Detail(详情), Entry(数据录入), 其他;
\nAPI 分为List(列表), Detail(详情), Add(增), Update(改), Delete(删), 其他;
\nUIView 自定义视图只有一种;
\nViewModel 只有一种, 包含API的增删改查;
命名(模板, 复制粘贴到文本框查看效果)如下:

IOPGoodsDetailController
IOPGoodsEntryController
IOPGoodsViewModel
IOPOrderListAPI
IOPOrderDetailAPI
IOPOrderAddAPI
IOPOrderUpdateAPI
IOPOrderDeleteAPI
IOPSearchView

"""

class NNBatchClassCreateController: NSViewController {
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = ""
        view.placeHolder = "请输入..."
        view.delegate = self
        return view;
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = ["UIViewController文件", "自定义UIView文件", "API文件", "ViewModel文件",]

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
    
    lazy var textViewOne: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont(name: "PingFangSC-Light", size: 13)
        view.isEditable = false
        view.backgroundColor = NSColor.background
        view.string = kBatchTips
        return view;
    }()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        title = "iOS类文件批量生成"
        view.addSubview(btn)
        view.addSubview(btnPop)
        view.addSubview(segmentCtl)
        view.addSubview(textView.enclosingScrollView!)
        view.addSubview(textViewOne.enclosingScrollView!)

        segmentCtl.isHidden = true
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
        
        textViewOne.enclosingScrollView!.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalTo(textView.enclosingScrollView!.snp.right).offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(textView.enclosingScrollView!).offset(0)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
    }
    
    // MARK: -funcitons
    /// 批量创建文件
    func batchCreateFile(_ text: String) {
        if text.count <= 0 {
            return
        }
        createFiles(text, type: btnPop.titleOfSelectedItem!.lowercased())
    }
    /// 按照类型创建文件
    func createFiles(_ text: String, type: String = "swift") {
        if text.count <= 0 {
            return
        }
        
        let separate = text.contains(";") ? ";" : "\n"
        let titles = text.components(separatedBy: separate)

        for e in titles.enumerated() {
            if e.element == "" {
                continue;
            }
            var name = e.element.trimmingCharacters(in: .whitespaces)
            name = name.trimmingCharacters(in: CharacterSet(charactersIn: "\n"))
            
            if name.hasSuffix("Controller") {
                NNBatchManager.createControllerFiles(name, type: type)

            } else if name.hasSuffix("View") {
                NNBatchManager.createUIViewFiles(name, type: type)

            } else if name.hasSuffix("ViewModel") {
                NNBatchManager.createViewModelFiles(name, type: type)

            } else if name.lowercased().hasSuffix("api") {
                NNBatchManager.createAPIFiles(name, type: type)

            } else {
                let msg = "'\(name)'必须包含Controller/View/ViewModel/API/Api后缀中的一种,否则无法自动生成"
                _ = NSAlert.show("错误", msg: msg, btnTitles: [kTitleSure], window: NSApp.keyWindow!)
            }
        }
    }
}

extension NNBatchClassCreateController: NSTextViewDelegate {

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
