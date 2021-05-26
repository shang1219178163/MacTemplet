//
//  NSPanelStudyController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/30.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand
import SnapKit

/// 文件选择
class NSPanelStudyController: NSViewController {

    lazy var btn: NSButton = {
        let view = NSButton(title: "选择文件", target: self, action: #selector(handleActionBtn(_:)))
        view.bezelStyle = .regularSquare
        view.lineBreakMode = .byCharWrapping
        view.tag = 100
        
        return view
    }()
    
    lazy var btnOne: NSButton = {
        let view = NSButton(title: "保存文件", target: self, action: #selector(handleActionBtn(_:)))
        view.bezelStyle = .regularSquare
        view.lineBreakMode = .byCharWrapping
        view.tag = 101

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
        view.addSubview(btnOne)
        
        DDLog(NSApplication.userName)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        btn.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
        
        btnOne.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(btn.snp.right).offset(20)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
    }

    // MARK: -funtions
    @objc func handleAction(_ sender: NSButton) {
        switch sender.tag {
        case 100:
            pickFile()
            
        case 101:
            saveFile(NSData(), name: "1212")
            
        default:
            break
        }
    }
    
    @objc func pickFile(_ allowedFileTypes: [String] = ["jpg","png"], allowsMultipleSelection: Bool = false) {
        
        let panel = NSOpenPanel()
         
        // prompt : 修改默认打开按钮的文字
//         panel.prompt = "打开"
        panel.message = "不要随便选择文件"
         // 设置文件打开的类型: 默认为空,表示可以选择任意类型的文件
        panel.allowedFileTypes = allowedFileTypes
        panel.allowsMultipleSelection = allowsMultipleSelection
//        panel.canCreateDirectories = true

        // 设置默认打开的文件路径
        let pathUrl = URL(string: "\(NSHomeDirectory())/Downloads")
        panel.directoryURL = pathUrl
//        openpanel.allowsMultipleSelection = false
        panel.delegate = self
         
        // 显示openpanel
        panel.begin { (response) in
            if response == NSApplication.ModalResponse.OK {
                for u in panel.urls {
                    print(u.absoluteString)
                }
            }
        }
     }
    
    @objc func saveFile(_ data: NSData, name: String, allowedFileTypes: [String] = ["jpg","png"]) {
        let panel = NSSavePanel()
        panel.title = "保存文件"
        panel.message = "请选择文件保存地址"
        panel.directoryURL = URL(string: "\(NSHomeDirectory())/Downloads")
        panel.nameFieldStringValue = name
        panel.allowsOtherFileTypes = true
        panel.allowedFileTypes = allowedFileTypes
        panel.isExtensionHidden = false
        panel.canCreateDirectories = true
        
        panel.begin { (response) in
            if response == .OK {
                if let path = panel.url?.path {
                    data.write(toFile: path, atomically: true)
                }
            }
        }
    }
    
}


extension NSPanelStudyController : NSOpenSavePanelDelegate{
        
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
