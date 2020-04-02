//
//  LittleActionController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/2.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

/// 小功能集合
class LittleActionController: NSViewController {

    var itemList: [NSButton] = []

    var font = NSFont.systemFont(ofSize: 14)
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor

        // Do any additional setup after loading the view.
        let str: String = String(String(repeating: "Button,", count: 15).dropLast())
        let list: [String] = str.components(separatedBy: ",")
        
        itemList = NSButton.createGroupView(.zero, list: list, numberOfRow: 4, padding: 8, target: self, action: #selector(handleAction(_:)), inView: view);
        
//        DDLog(view.frame, view.bounds)
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.5)
        NSButton.setupConstraint(frame, items: itemList)
    }
    
    // MARK: -funtions
    @objc func handleAction(_ sender: NNButton) {
        DDLog("\(sender.tag)")

        switch sender.tag {
        case 0:
            fontPick()
        case 1:
            colorPick()

        default:
            break
        }
    }
    
    func fontPick() {
        let manager = NSFontManager.shared
        manager.target = self
        manager.action = #selector(handleActionFont(_:))
        
        manager.orderFrontFontPanel(self)
    }
    
    func colorPick() {
        let panel = NSColorPanel.shared
        panel.mode = .crayon
        panel.setTarget(self)
        panel.setAction(#selector(handleActionColor(_:)))
        
        panel.makeKeyAndOrderFront(self)
    }
    
    @objc func handleActionFont(_ sender: NSFontManager) {
        font = sender.convert(self.font)
        DDLog("pointSize：\(font.pointSize) ，fontName : \(font.fontName) , familyName : \(font.familyName)");

    }
    
    @objc func handleActionColor(_ sender: NSColorPanel) {
        view.layer?.backgroundColor = sender.color.cgColor

    }
    

}
