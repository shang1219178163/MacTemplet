//
//  TmpViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import CoreFoundation

@available(OSX 10.15, *)
class TmpViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor
//        setupClickView()
//        setupSearchField()
        
        let switchCtl = NSSwitch(frame: CGRectMake(10, 110, 100, 100));
        switchCtl.state = .on
        view.addSubview(switchCtl);
        
        label.frame = CGRectMake(10, switchCtl.maxY + 10, 100, 25)
        label.stringValue = "标题显示"
        view.addSubview(label);
        
//        label.backgroundColor = NSColor.red

        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        

    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
           
//        DDLog(NNClassFromString("QAZViewController"))
    }
    
    func setupClickView() {
        let click = NSClickGestureRecognizer();
        view.addGestureRecognizer(click)
//        click.addAction { (reco) in
//            DDLog(reco);
//        }
        
        click.addAction {reco in
//            DDLog("click");
            DDLog(reco.view)
        }
    }
    
    func setupSearchField() {
        let searchField = NSSearchField(frame: CGRectMake(10, 10, 200, 30));
        searchField.searchMenuTemplate = NSSearchField.createRecentMenu()
//        searchTextField.
        view.addSubview(searchField);

        let titles = ["All", "First Name", "Last Name", ]
        let menu: NSMenu = NSMenu.createMenu(itemTitles: titles) { (item) in
            DDLog(item)
        }
        searchField.searchMenuTemplate = menu
    }
    
    @objc func changeSearchFieldItem(_ sender: NSMenuItem){
        DDLog(sender);
//        (self.searchField.cell as? NSSearchFieldCell)?.placeholderString = sender.title
        
    }
    
    lazy var label: NSTextField = {
        let view = NSTextField(frame: .zero)
        view.isBordered = false;  ///是否显示边框
        view.wantsLayer = true;
        view.isEditable = false;
        view.drawsBackground = true;
        view.backgroundColor = NSColor.clear

        return view;
    }()
    

}

