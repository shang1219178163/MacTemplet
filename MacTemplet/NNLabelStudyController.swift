//
//  NNLabelStudyController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/26.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SnapKit
import SwiftExpand
//import NNLabel

class NNLabelStudyController: NSViewController {
    

    lazy var label: NSTextField = {
        let view = NSTextField(frame: .zero)
        view.isBordered = false;  ///是否显示边框
        view.wantsLayer = true;
        view.isEditable = false;
        view.drawsBackground = true;
        view.backgroundColor = NSColor.clear
        
        view.usesSingleLineMode = false
        view.lineBreakMode = .byWordWrapping

        view.stringValue = "标题显示"

        return view;
    }()
    
    lazy var labelOne: NNLabel = {
        let view = NNLabel(frame: .zero)
//        view.contentVerticalAlignment = .top
//        view.textAlignment = .left
        view.highlightedTextColor = NSColor.red
//        view.isHighlighted = true
        
        view.toolTip = "3月25日，SOHO中国有限公司发布了2019年度业绩公告。";
                
//        view.text = "3月25日，SOHO中国有限公司发布了2019年度业绩公告。"
        view.text = """
        3月25日，SOHO中国有限公司发布了2019年度业绩公告。
        或许，这是SOHO中国的最后一份年报。此前在3月10日，市场消息传出黑石要溢价私有化SOHO中国，当天股价应声暴涨37%到4.1港元，据称黑石的报价为6港元每股。公司后续也承认了双方正在商讨交易。
        “中庸”应该是这份年报最贴切的形容词，2019年出售资产的传闻屡有传出的结果却没有任何大宗资产出售，各项核心财务数据仅有细微的变化。
        公司主席潘石屹仿佛也没有把注意力放在这份年报中，2018年的主席报告足足有4页，潘石屹和股东们语重心长的分享了中国房地产形势，SOHO中国的发展理念和目标。
        但在2019年年报中的主席报告却只有2页，简单叙述了整体市场情况与项目情况，并没有提及股东们最关心的私有化问题，甚至全篇年度报告都只字未提。
"""
//        view.isUserInteractionEnabled = true
//        view.isEnabled = false
        view.actionBlock { (sender) in
            DDLog(sender)
        }
//        view.textColor = NSColor.lightBlue
//        view.font = NSFont.systemFont(ofSize: 17)
        return view;
    }()
    
    @objc func handleActionBtn(_ sender: NSButton) {
        DDLog(sender.title)
    }
    
    // MARK: -life cycle
    override func loadView() {
        // 设置 ViewController 大小同 mainWindow
        guard let windowRect = NSApplication.shared.mainWindow?.frame else { return }
        view = NSView(frame: windowRect)
        view.wantsLayer = true;
        view.layer!.backgroundColor = NSColor.white.cgColor;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(label);
        view.addSubview(labelOne);

        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20);
            make.left.equalToSuperview().offset(20);
            make.right.equalToSuperview().offset(-20);
            make.height.equalTo(80);
        }

        labelOne.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(10);
            make.left.equalToSuperview().offset(20);
            make.right.equalToSuperview().offset(-20);
            make.height.equalTo(180);
        }
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
           
//        DDLog(NNClassFromString("QAZViewController"))
    }

}


