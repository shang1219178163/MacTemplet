//
//  OthersViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import Speech

/// 其他例子集合
class OthersViewController: NSViewController {
    
    lazy var tabView: NSTabView = {
        let view = NSTabView()
        view.tabPosition = .top
        view.tabViewBorderType = .line
        view.delegate = self
        return view
    }()
    
    lazy var list: [(NSViewController, String)] = {
        return [(NSOutlineViewController(), "NSOutlineView"),
                (CollectionViewController(), "Collection"),
//                (FirstViewController() , "First"),
//                (ListViewController() , "ListVC"),
//                (NNListViewController() , "NNListVC"),
                  (NNTextViewContoller(), "NNTextView"),
                  (NSPanelStudyController(), "Files pickAndSave"),
                  (AppIconActionController(), "AppIcon"),
                  (NSAlertStudyController(), "NSAlertStudy"),
                  (LittleActionController(), "小功能"),
                  (ShowViewController(), "控制器呈现"),
                  (BookListController(), "折叠分段列表"),
//                  (NSTestViewController() , "测试模块"),
//                  (TmpViewController() , "Tmp模块"),
//                  (NSPanelStudyController() , "NSOpenPanelStud"),
//                  (NSStackViewController() , "StackView"),
//                  (MapViewController() , "MapView"),
//                  (FileController() , "File处理"),
                      ]
    }()
    

    // MARK: -life cycle
    override func loadView() {
        // 设置 ViewController 大小同 mainWindow
        guard let windowRect = NSApplication.shared.mainWindow?.frame else { return }
        view = NSView(frame: windowRect)
        view.wantsLayer = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupUI()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        tabView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10);
            make.left.equalToSuperview().offset(10);
            make.right.equalToSuperview().offset(-10);
            make.bottom.equalToSuperview().offset(-10);
        }
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
//        let synthetizer = NSSpeechSynthesizer(voice: nil)
//        synthetizer?.startSpeaking("Welcome to app'codeHelper")
    }
    
    // MARK: -funtions
    func setupUI() {
        tabView.addItems(list)
        view.addSubview(tabView)
    }
}

extension OthersViewController: NSTabViewDelegate{
    
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        guard let tabViewItem = tabViewItem else { return }
        let index = tabView.tabViewItems.firstIndex(of: tabViewItem)
        print("\(#function):\(index ?? 0)")
    }
}
