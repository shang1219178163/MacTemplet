//
//  NSOpenPanelStudyController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/30.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import SnapKit

/// 文件选择
class NSOpenPanelStudyController: NSViewController {

    lazy var btn: NSButton = {
        let view = NSButton(title: "Button", target: self, action: #selector(handleActionBtn(_:)))
        view.bezelStyle = .regularSquare
        view.lineBreakMode = .byCharWrapping

        return view
    }()
    
    @objc func handleActionBtn(_ sender: NSButton) {
        handleAction(sender)
    }
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(btn)
        
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        btn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.width.equalTo(80)
            make.height.equalTo(50)
        }
    }

    // MARK: -funtions
    @objc func handleAction(_ sender: Any) {
         // 1. 创建openPanel 对象
         let openpanel = NSOpenPanel()
         
         // prompt : 修改默认打开按钮的文字
         openpanel.prompt = "打开"
         openpanel.message = "不要随便选择文件"
         // 设置文件打开的类型: 默认为空,表示可以选择任意类型的文件
 //        openpanel.allowedFileTypes = ["jpg","json"]
         openpanel.canCreateDirectories = true
         
         // 设置默认打开的文件路径
         let pathUrl = URL(string:"/Users/shang/Downloads")
         openpanel.directoryURL = pathUrl
 //        openpanel.allowsMultipleSelection = false
         openpanel.delegate = self
         
         // 显示openpanel
         openpanel.beginSheetModal(for: view.window!) { (result) in
             print("\(result)")
             if result == NSApplication.ModalResponse.OK {
                 for u in openpanel.urls {
                     print(u.absoluteString)
                 }
             }
         }
     }
}


extension NSOpenPanelStudyController : NSOpenSavePanelDelegate{
    
    // NSOpenPanel 支持
    
    // 当更改了默认打开目录时,调用此代理方法
    func panel(_ sender: Any, didChangeToDirectoryURL url: URL?) {
        print("更换了文件夹")
    }
    
    // 每次打开都会调用这个代理方法,询问是否支持打开该url(被多次调用)
    func panel(_ sender: Any, shouldEnable url: URL) -> Bool {
        print("是否支持打开本url\(url.absoluteString)")
        return true
    }
    // 用户点击确认(或打开)按钮是,会调用这个代理方法
    func panel(_ sender: Any, validate url: URL) throws {
        print("用户确认选择后,可以进行验证url操作")
    }
    // 用户每次选择时,如果支持打开本路径的文件,则会调用这个代理方法,通知了用户已经变更选择
    // 会被多次调用
    func panelSelectionDidChange(_ sender: Any?) {
        print("用户改变了选择")
    }
    
     // 其他的方法是供NSSavePanel使用
    
    
}
