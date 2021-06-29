//
//  LittleActionController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/2.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

/// 小功能集合
class LittleActionController: NSViewController {

    var itemList: [NSButton] = []

    var font = NSFont.systemFont(ofSize: 14)
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor

        // Do any additional setup after loading the view.
//        let str: String = String(String(repeating: "Button,", count: 15).dropLast())
//        let list: [String] = str.components(separatedBy: ",")
        let list: [String] = ["sheet弹窗", "字体选择", "颜色选择", "Button", "Button", "Button", ]
        itemList = list.enumerated().map({ (e) -> NSButton in
            let sender = NSButton(title: e.element, target: self, action: #selector(handleAction(_:)))
            sender.bezelStyle = .regularSquare
            sender.lineBreakMode = .byCharWrapping
            sender.tag = e.offset
            return sender
        })
        
        itemList.forEach { (e) in
            view.addSubview(e)
        }
//        DDLog(view.frame, view.bounds)
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.1)
        itemList.updateItemsConstraint(frame, numberOfRow: 6)
    }
    
    // MARK: -funtions
    @objc func handleAction(_ sender: NNButton) {
        DDLog("\(sender.tag)")

        switch sender.tag {
        case 1:
            fontPick()
        case 2:
            colorPick()
            
        default:
            showSheetController()
            break
        }
    }
    
    func fontPick() {
        let manager = NSFontManager.shared
        manager.target = self
        manager.action = #selector(handleActionFont(_:))
        
        manager.orderFrontFontPanel(self)
    }
    
    @objc func handleActionFont(_ sender: NSFontManager) {
        font = sender.convert(self.font)
        DDLog("pointSize：\(font.pointSize) ，fontName : \(font.fontName) , familyName : \(font.familyName)");

    }
    
    func colorPick() {
        let panel = NSColorPanel.shared
        panel.mode = .crayon
        panel.setTarget(self)
        panel.setAction(#selector(handleActionColor(_:)))
        
        panel.makeKeyAndOrderFront(self)
    }
        
    @objc func handleActionColor(_ sender: NSColorPanel) {
        view.layer?.backgroundColor = sender.color.cgColor

    }
    
    func showSheetController() {
        let controller = NSCtrFromString("NNDatePickerController")
        let rect = CGRectMake(0, 0, kScreenWidth*0.25, kScreenHeight*0.25)
//        controller.preferredContentSize = rect.size
//
//        let window = NSWindow.create(rect, controller: controller)
//        window.level = .statusBar
//        NSApp.mainWindow?.beginSheet(window, completionHandler: { (response) in
//            DDLog(response)
//        })
        NSWindow.showSheet(with: controller, size: rect.size) { (response) in
            DDLog(response)
        }
    }

}
