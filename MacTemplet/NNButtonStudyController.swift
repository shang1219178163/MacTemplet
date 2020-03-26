//
//  ViewController.swift
//  AAButton
//
//  Created by Bin Shang on 2020/3/23.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand
import NNButton


class NNButtonStudyController: NSViewController {
    
    lazy var stackView: NSStackView = {
        //创建StackView
        let stackView = NSStackView(frame: self.view.bounds)
        //设置子视图间隔
        stackView.spacing = 30
        //子视图的高度或宽度保持一致
//        stackView.distribution = .fillEqually
        stackView.distribution = .fillProportionally

        return stackView;
    }()
    
    lazy var btnOne: NNButton = {
        let view = NNButton(title: "NNButton", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.toolTip = "btnOne"
        view.showHighlighted = true

        view.setTitle("normal", for: .normal)
        view.setTitle("disabled", for: .disabled)
        view.setTitle("selected", for: .selected)
        view.setTitle("highlighted", for: .highlighted)
        view.setTitle("hover", for: .hover)

        view.setTitleColor(NSColor.red, for: .normal)
        view.setTitleColor(NSColor.blue, for: .selected)
        view.setTitleColor(NSColor.white, for: .highlighted)
        view.setTitleColor(NSColor.orange, for: .hover)

        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightBlue), for: .normal)
        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightGreen), for: .selected)
        view.setBackgroundImage(NSImage.imageWithColor(NSColor.red), for: .highlighted)
        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightOrange), for: .hover)

//        view.wantsLayer = true
//        view.layer?.borderColor = NSColor.green.cgColor
//        view.layer?.borderWidth = 1
        view.layer?.cornerRadius = 10
        
        view.stateBlock { (sender, state) in
            DDLog("\(sender)_\(state)")
        }
        
        view.addActionHandler({ (control) in
            guard let sender = control as? NNButton else { return }
            sender.selected = !sender.selected
//            sender.isHighlighted = !sender.isHighlighted
            DDLog("\(control)_\(sender.selected)")
        })
        return view
    }()
    
    
    lazy var btnTwo: NNButton = {
        let view = NNButton(title: "disabled", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.setTitle("normal", for: .normal)
        view.setTitle("disabled", for: .disabled)
        view.setTitle("selected", for: .selected)
        view.setTitle("hover", for: .hover)
        view.setTitle("highlighted", for: .highlighted)
        
        view.wantsLayer = true
        view.layer?.borderColor = view.titleColor.cgColor
        view.layer?.borderWidth = 1
        view.layer?.cornerRadius = 10
        view.isEnabled = false
        
        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    
    lazy var btnThree: NNButton = {
        let view = NNButton(title: "normal", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.setTitle("normal", for: .normal)
        view.setTitle("disabled", for: .disabled)
        view.setTitle("selected", for: .selected)
        
        view.setTitleColor(NSColor.white, for: .normal)
        view.setTitleColor(NSColor.blue, for: .selected)
//        view.setTitleColor(NSColor.white, for: .highlighted)
//        view.setTitleColor(NSColor.orange, for: .hover)
//        view.setTitleColor(NSColor.red, for: .normal)

        view.setBackgroundImage(NSImage(color: NSColor.lightBlue), for: .normal)
//        view.setBackgroundImage(NSImage.imageWithColor(NSColor.white), for: .hover)

        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightGreen), for: .selected)
//        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightBlue), for: .highlighted)
//        view.setBackgroundImage(NSImage.imageWithColor(NSColor.white), for: .highlighted)
        view.setBorderColor(NSColor.red, for: .hover)

//        view.wantsLayer = true
//        view.layer?.borderColor = view.titleColor.cgColor
//        view.layer?.borderWidth = 1
//        view.layer?.cornerRadius = 10

        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()

    lazy var btnFour: NNButton = {
        let view = NNButton(title: "normal", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.setTitle("normal", for: .normal)
//        view.setTitle("disabled", for: .disabled)
//        view.setTitle("selected", for: .selected)
//        view.setTitle("hover", for: .hover)
//        view.setTitle("highlighted", for: .highlighted)
        
        view.setTitleColor(NSColor.lightBlue, for: .normal)

//        view.setBackgroundImage(NSImage.imageWithColor(NSColor.white), for: .normal)
        
        view.setBorderColor(view.titleColor, for: .normal)
        view.setBorderWidth(3, for: .normal)
        view.setBorderWidth(5, for: .hover)

        view.setCornerRadius(8, for: .normal)

//        view.wantsLayer = true
//        view.layer?.borderColor = NSColor.red.cgColor
//        view.layer?.borderWidth = 15
//        view.layer?.cornerRadius = 5

        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnFive: NNButton = {
        let view = NNButton(type: .typeText)
        view.setTitle("NNButton_typeText", for: .normal)
//        view.isEnabled = false

        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnSix: NNButton = {
        let view = NNButton(type: .type1)
        view.setTitle("NNButton_type1", for: .normal)
        view.setTitleColor(NSColor.lightBlue, for: .normal)
//        view.isEnabled = false

        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnSeven: NNButton = {
        let view = NNButton(type: .type2)
        view.setTitle("NNButton_type2", for: .normal)
//        view.isEnabled = false

        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnEight: NNButton = {
        let view = NNButton(type: .type2)
        view.setTitle("NNButton_disabled", for: .normal)
        view.isEnabled = false
        
        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnNine: NSButton = {
        let view = NSButton(title: "\n嗯，当不适合的文本自动以多行显示时，没有选择吗？我应该手动插入换行…\n", target: self, action: #selector(handleActionBtn(_:)))
        view.bezelStyle = .regularSquare
        view.lineBreakMode = .byCharWrapping

        return view
    }()
    
    lazy var btnTen: NNButton = {
        let view = NNButton(type: .type2)
        view.setTitle("嗯，当不适合的文本自动以多行显示时，没有选择吗？我应该手动插入换行…", for: .normal)
        view.font = NSFont.systemFont(ofSize: 13)

        view.addTarget(self, action: #selector(handleActionBtn(_:)))

        return view
    }()
    
    @objc func handleActionBtn(_ sender: NNButton) {
//        sender.selected = !sender.selected
//        DDLog("\(sender)_\(sender.selected)_\(sender.isHighlighted)")
        
//        sender.layer?.cornerRadius = sender.selected ? 10 : 0
        
        DDLog("\(sender)")

//        if sender.isKind(of: OOButton.classForCoder()) {
//            DDLog("\(sender)")
//        }
    }
    
    var itemList: [NSButton] = []
    
    // MARK: -lifecycle
    override func loadView() {
        // 设置 ViewController 大小同 mainWindow
        guard let windowRect = NSApplication.shared.mainWindow?.frame else { return }
        view = NSView(frame: windowRect)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.wantsLayer = true;
        view.layer!.backgroundColor = NSColor.white.cgColor;
        
        
//        stackView.addArrangedSubview(btnOne)
//        stackView.addArrangedSubview(btnTwo)
//        stackView.addArrangedSubview(btnThree)
//        stackView.addArrangedSubview(btnFour)
//
//        view.addSubview(stackView)
        
        btnOne.layer?.cornerRadius = 5
        btnTwo.layer?.cornerRadius = 5
        btnThree.layer?.cornerRadius = 5
        btnFour.layer?.cornerRadius = 5
        btnFive.layer?.cornerRadius = 5
        btnSix.layer?.cornerRadius = 5
        btnSeven.layer?.cornerRadius = 5
        btnEight.layer?.cornerRadius = 5

        itemList = [btnOne, btnTwo, btnThree, btnFour, btnFive, btnSix, btnSeven, btnEight, btnNine, btnTen]
        let rowCount: Int = itemList.count%4 == 0 ? itemList.count/4 : itemList.count/4 + 1
        let rect = CGRectMake(0, 0, view.frame.width, CGFloat(rowCount*70))
        setupConstraint(rect)
        
        view.getViewLayer()
        print(view.subviews)
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func setupConstraint(_ bounds: CGRect) {
        if itemList.count == 0 || bounds.width <= 0 {
            return;
        }
        
        let numberOfRow: Int = 4
        let padding: CGFloat = 8.0
        
        let rowCount = itemList.count % numberOfRow == 0 ? itemList.count/numberOfRow : itemList.count/numberOfRow + 1;
        let itemWidth = (bounds.width - CGFloat(numberOfRow - 1)*padding)/CGFloat(numberOfRow)
        let itemHeight = (bounds.height - CGFloat(rowCount - 1)*padding)/CGFloat(rowCount)
        
        for e in itemList.enumerated() {
            let x = CGFloat(e.offset % numberOfRow) * (itemWidth + padding)
            let y = CGFloat(e.offset / numberOfRow) * (itemHeight + padding)
            let rect = CGRect(x: x, y: y, width: itemWidth, height: itemHeight)
            
            let sender = e.element;
            sender.frame = rect;
            view.addSubview(sender)
        }
    }

}

