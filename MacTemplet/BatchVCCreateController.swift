//
//  BatchVCCreateController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import SnapKit
import SnapKitExtend

class BatchVCCreateController: NSViewController {
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 12)
        view.string = ""
        view.delegate = self
        return view;
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = ["UIViewController", "API文件"]
        return view;
    }()

    lazy var btn: NSButton = {
        let view = NSButton(title: "done", target: nil, action: nil)
        view.setButtonType(.momentaryPushIn)
        view.bezelStyle = .shadowlessSquare
//        view.bezelColor = NSColor.blue.withAlphaComponent(0.5)
        view.addActionHandler { (control) in
            NSApp.mainWindow?.makeFirstResponder(nil)
            DDLog(control)
        }
        return view;
    }()
    
    // MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        title = "类文件批量生成"
        view.addSubview(btn)
        view.addSubview(segmentCtl)
        view.addSubview(textView)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
                
        btn.snp.makeConstraints { (make) in
            make.right.bottom.equalToSuperview()
            make.height.equalTo(35)
            make.width.equalTo(100)
        }
        
        let width = CGFloat(segmentCtl.items.count)*100
        segmentCtl.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(width)
        }
        
//        textView.frame = CGRectMake(0, 0, self.view.bounds.width*0.5, self.view.bounds.height - 50)
        textView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.bottom.equalTo(btn.snp.top).offset(-10)
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        DDLog(NNCopyRightModel.getCopyRight(with: "IOPParkListController", type: "Swift"))
    }
    
    func getTitles(_ string: String) -> [String] {
        if !string.contains("\n") {
            return [string]
        }
        return (string as NSString).components(separatedBy: "\n")
    }
    
}

extension BatchVCCreateController: NSTextViewDelegate {

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
        let titles = getTitles(textView.string)
        
//        DDLog(textView.string)
//        if textView.string.contains("\n") {
//            DDLog("包含换行符")
//        }
    }
}
