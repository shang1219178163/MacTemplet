//
//  TmpViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import CoreFoundation

import CocoaExpand

@available(OSX 10.15, *)
class TmpViewController: NSViewController {

    lazy var label: NSTextField = {
        let view = NSTextField(frame: .zero)
        view.isBordered = false;  ///是否显示边框
        view.wantsLayer = true;
        view.isEditable = false;
        view.drawsBackground = true;
        view.backgroundColor = NSColor.clear

        view.stringValue = "标题显示"

        return view;
    }()
    
    lazy var switchCtl: NSSwitch = {
        let view = NSSwitch(frame: .zero)
        view.state = .on

//        view.isBordered = false;  ///是否显示边框
//        view.wantsLayer = true;
        return view;
    }()
    
    lazy var checkBox: NSButton = {
        let view = NSButton(checkboxWithTitle: "checkBox", target: self, action: #selector(handleActionBtn(_:)))
//        view.isBordered = false;  ///是否显示边框
//        view.wantsLayer = true;

        return view;
    }()
    
    lazy var radioBox: NSButton = {
        let view = NSButton(radioButtonWithTitle: "radio", target: self, action: #selector(handleActionBtn(_:)))
//        view.isBordered = false;  ///是否显示边框
//        view.wantsLayer = true;

        return view;
    }()
    
    @objc func handleActionBtn(_ sender: NSButton) {
        DDLog(sender.title)
    }
    
    // MARK: -life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor
//        setupClickView()
//        setupSearchField()
        
        
        view.addSubview(label);
//        view.addSubview(switchCtl);
        view.addSubview(checkBox);
        view.addSubview(radioBox);

        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20);
            make.left.equalToSuperview().offset(20);
            make.right.equalToSuperview().offset(-20);
            make.height.equalTo(25);
        }

//        switchCtl.snp.makeConstraints { (make) in
//            make.top.equalTo(label.snp.bottom).offset(10);
//            make.left.equalToSuperview().offset(20);
//            make.right.equalToSuperview().offset(-20);
//            make.height.equalTo(35);
//        }
        
        checkBox.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(10);
            make.left.equalToSuperview().offset(20);
            make.right.equalToSuperview().offset(-20);
            make.height.equalTo(35);
        }
        
        radioBox.snp.makeConstraints { (make) in
            make.top.equalTo(checkBox.snp.bottom).offset(10);
            make.left.equalToSuperview().offset(20);
            make.right.equalToSuperview().offset(-20);
            make.height.equalTo(35);
        }
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
    

}

