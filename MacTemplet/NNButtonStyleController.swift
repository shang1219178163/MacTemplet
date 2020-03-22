//
//  NNButtonStyleController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/15.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

import CocoaExpand

class NNButtonStyleController: NSViewController {
    
    lazy var flowLayout: NSCollectionViewFlowLayout = {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 160.0, height: 140.0)
        layout.sectionInset = NSEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        layout.minimumInteritemSpacing = 20.0
        layout.minimumLineSpacing = 20.0
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()
    
    lazy var collectionView: NNCollectionView = {
        let collectionView = NNCollectionView(frame: self.view.bounds)
        collectionView.collectionViewLayout = flowLayout
        collectionView.isSelectable = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.register(NNCollectionViewItem.classForCoder(), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNCollectionViewItem"))
//        collectionView.register(NNHeaderFooterView.classForCoder(), forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNHeaderFooterView"))
        collectionView.register(cellType: NNCollectionViewItem.self)
        collectionView.register(supplementaryViewType: NNHeaderFooterView.self)
        self.view.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
        return collectionView
    }()
    
    lazy var btn: HHButton = {
        let view = HHButton(title: "继承按钮", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        
        view.addActionHandler({ (control) in
            DDLog(control)
        })
        return view
    }()

    lazy var btnOne: NNButton = {
        let view = NNButton(title: "自定义按钮", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.toolTip = "btnOne"

        view.setTitle("normal", for: .normal)
        view.setTitle("disabled", for: .disabled)
        view.setTitle("selected", for: .selected)
        view.setTitle("hover", for: .hover)
        view.setTitle("highlighted", for: .highlighted)

        view.setTitleColor(NSColor.white, for: .normal)
        view.setTitleColor(NSColor.blue, for: .selected)
        view.setTitleColor(NSColor.orange, for: .hover)
        
        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightBlue), for: .normal)
        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightGreen), for: .selected)
        view.setBackgroundImage(NSImage.imageWithColor(NSColor.lightOrange), for: .hover)
        
//        view.wantsLayer = true
//        view.layer?.borderColor = NSColor.green.cgColor
//        view.layer?.borderWidth = 1.5
        view.layer?.cornerRadius = 10
        
        view.addActionHandler({ (control) in
            guard let sender = control as? NNButton else { return }
            sender.selected = !sender.selected
//            sender.isHighlighted = !sender.isHighlighted
            DDLog("\(control)_\(sender.selected)")
        })
//        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnTwo: NNButton = {
        let view = NNButton(title: "自定义按钮", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        view.setTitle("normal", for: .normal)
        view.setTitle("disabled", for: .disabled)
        view.setTitle("selected", for: .selected)
        view.setTitle("hover", for: .hover)
        view.setTitle("highlighted", for: .highlighted)

//        view.setTitle("highlighted", for: .highlighted)
//        view.setTitle("highlighted", for: .highlighted)
//        view.setTitle("highlighted", for: .highlighted)
        
        view.wantsLayer = true
        view.layer?.borderColor = NSColor.green.cgColor
        view.layer?.borderWidth = 1.5
        view.layer?.cornerRadius = 10
        view.isEnabled = false

//        view.addActionHandler({ (control) in
//            guard let sender = control as? HHButton else { return }
//            sender.selected = !sender.selected
//            sender.isHighlighted = !sender.isHighlighted
//            DDLog("\(control)_\(sender.selected)_\(sender.isHighlighted)")
//        })
        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnThree: AAButton = {
        let view = AAButton(title: "AAButton", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
//        view.backgroundColor = NSColor.white
        
//        view.wantsLayer = true
//        view.layer?.borderColor = NSColor.green.cgColor
//        view.layer?.borderWidth = 1.5
//        view.layer?.cornerRadius = 10

        view.addTarget(self, action: #selector(handleActionBtn(_:)))
        return view
    }()
    
    lazy var btnFour: OOButton = {
        let view = OOButton(title: "圆形图像绘制", target: nil, action: nil)
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        view.layer?.backgroundColor = NSColor.orange.cgColor
        view.image = NSImage(named: "AppIcon")
        view.titleColor = NSColor.white
        view.strokeColor = NSColor.clear
        view.fillColor = NSColor.green

//        view.backgroundColor = NSColor.orange
//        view.bezelStyle = .shadowlessSquare
//        (view.cell as! NSButtonCell).highlightsBy = .contentsCellMask
        
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
    
    var singleSectionMode = true
    
    let buttonTypes = [NSButton.ButtonType.momentaryLight, NSButton.ButtonType.pushOnPushOff,
                       NSButton.ButtonType.toggle, NSButton.ButtonType.`switch`,
                       NSButton.ButtonType.momentaryChange, NSButton.ButtonType.onOff,
                       NSButton.ButtonType.momentaryPushIn, NSButton.ButtonType.accelerator,
                       NSButton.ButtonType.multiLevelAccelerator]
        
    let bezelStyles = [NSButton.BezelStyle.rounded, NSButton.BezelStyle.regularSquare,
                       NSButton.BezelStyle.disclosure, NSButton.BezelStyle.shadowlessSquare,
                       NSButton.BezelStyle.circular, NSButton.BezelStyle.texturedSquare,
                       NSButton.BezelStyle.helpButton, NSButton.BezelStyle.smallSquare,
                       NSButton.BezelStyle.texturedRounded, NSButton.BezelStyle.roundRect,
                       NSButton.BezelStyle.recessed, NSButton.BezelStyle.roundedDisclosure,
                       NSButton.BezelStyle.inline]
    
    let bezelStyleList = [
                       NSButton.BezelStyle.disclosure,
                       NSButton.BezelStyle.circular,
                       NSButton.BezelStyle.helpButton,
                       NSButton.BezelStyle.roundedDisclosure,
                       ]
    
    let bezelStyleDes = ["NSButton.BezelStyle.rounded", "NSButton.BezelStyle.regularSquare",
                       "NSButton.BezelStyle.disclosure", "NSButton.BezelStyle.shadowlessSquare",
                       "NSButton.BezelStyle.circular", "NSButton.BezelStyle.texturedSquare",
                       "NSButton.BezelStyle.helpButton", "NSButton.BezelStyle.smallSquare",
                       "NSButton.BezelStyle.texturedRounded", "NSButton.BezelStyle.roundRect",
                       "NSButton.BezelStyle.recessed", "NSButton.BezelStyle.roundedDisclosure",
                       "NSButton.BezelStyle.inline"]
    
    let imageScalings = [NSImageScaling.scaleProportionallyDown, NSImageScaling.scaleAxesIndependently,
                         NSImageScaling.scaleNone, NSImageScaling.scaleProportionallyUpOrDown,]
    
    // MARK: -life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addSubview(collectionView.enclosingScrollView!)
        collectionView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        collectionView.enclosingScrollView!.frame = view.bounds
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        DDLog(btnTwo.value(forKey: "mdicHighlighted"))
    }
    
}

extension NNButtonStyleController : NSCollectionViewDataSource {
  
  func numberOfSections(in collectionView: NSCollectionView) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
    return bezelStyles.count + 5
  }
  
  func collectionView(_ itemForRepresentedObjectAtcollectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    
//    let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNCollectionViewItem"), for: indexPath)
    guard let item = collectionView.dequeueReusableCell(for: NNCollectionViewItem.self, indexPath: indexPath) as NNCollectionViewItem? else {
        return NSCollectionViewItem()
    }

    item.textLabel.isHidden = true
    item.textLabelBottom.stringValue = "{\(indexPath.section),\(indexPath.item)}"
    
    if buttonTypes.count > indexPath.item {
        item.btn.setButtonType(buttonTypes[indexPath.item])
    }
    if bezelStyles.count > indexPath.item {
        item.btn.bezelStyle = bezelStyles[indexPath.item]
    }
    if bezelStyleDes.count > indexPath.item {
        item.btn.toolTip = bezelStyleDes[indexPath.item]
        item.textLabelBottom.stringValue = ".\(bezelStyleDes[indexPath.item].components(separatedBy: ".").last ?? "{\(indexPath.section),\(indexPath.item)}")"
    }
    
    if #available(macOS 10.12.2, *) {
        item.btn.bezelColor = NSColor.orange
    }
//    item.btn.isBordered = true
//    item.btn.isTransparent = true

    item.btn.wantsLayer = true
    item.btn.layer?.backgroundColor = NSColor.green.cgColor
    
//    item.btn.layer?.borderColor = NSColor.red.cgColor
//    item.btn.layer?.borderWidth = 1.5
//    item.btn.layer?.cornerRadius = 3
//    item.btn.layer?.masksToBounds = true
    item.btn.alternateTitle = "反选"
//    item.btn.image = NSImage(named: "AppIcon")
//    item.btn.imageScaling = NSImageScaling.scaleNone

    let attDic = NSAttributedString.attrDict()
    item.btn.attributedTitle = NSAttributedString(string: "UIButton", attributes: attDic)
    
//    item.btn.normalColor = NSColor.black
//    item.btn.hoverColor = NSColor.red
//    item.btn.backgroundNormalColor = NSColor.black
//    item.btn.backgroundHoverColor = NSColor.red

    if bezelStyleList.contains(item.btn.bezelStyle) {
        item.btn.title = ""
        item.btn.alternateTitle = ""
    }
    
    if item.btn.bezelStyle == .shadowlessSquare {
        ///取消高亮
        (item.btn.cell as! NSButtonCell).highlightsBy = []
    }
    
    if item.btn.bezelStyle == .inline {
        if #available(macOS 10.14, *) {
            item.btn.isBordered = false
//            item.btn.contentTintColor = NSColor.red
        }
    }

    if indexPath.item == 13 {
        item.btn.isHidden = true
        
        item.view.addSubview(btn)
        btn.center = CGPoint(x: 70, y: 70)
        
//        btn.bezelStyle = .texturedSquare
        btn.wantsLayer = true
        btn.toolTip = btn.title
//        btn.alignment = .center

        btn.hasBorder = true
//        btn.layer?.backgroundColor = NSColor.green.cgColor
        
        btn.layer?.borderColor = NSColor.red.cgColor
        btn.layer?.borderWidth = 1.5
        btn.layer?.cornerRadius = 10
//        btn.layer?.masksToBounds = true
        
//        btn.image = NSImage(named: "AppIcon")!
        
        btn.cornerNormalRadius = 1
        btn.cornerHoverRadius = 4
        btn.cornerHighlightRadius = 8
        btn.cornerSelectedRadius = 12
////
        btn.borderNormalWidth = 1
        btn.borderHoverWidth = 4
        btn.borderHighlightWidth = 8
        btn.borderSelectedWidth = 12

        btn.borderNormalColor = NSColor.random
        btn.borderHoverColor = NSColor.random
        btn.borderHighlightColor = NSColor.random
        btn.borderSelectedColor = NSColor.random
        
//        btn.normalColor = NSColor.blue
//        btn.hoverColor = NSColor.yellow
//        btn.highlightColor = NSColor.brown
//        btn.selectedColor = NSColor.orange

        btn.image = NSImage(named: "AppIcon")
        btn.image = NSImage(named: "AppIcon")

        btn.imageScaling = NSImageScaling.scaleNone
        btn.normalImage = NSImage(named: "Item_center_H")!
        btn.hoverImage = NSImage(named: "Item_first_H")!
        btn.highlightImage = NSImage(named: "Item_fourth_H")!
        btn.selectedImage = NSImage(named: "Item_second_H")!

//        btn.backgroundNormalColor = NSColor.yellow
//        btn.backgroundHoverColor = NSColor.lightGreen
//        btn.backgroundHighlightColor = NSColor.lightOrange
//        btn.backgroundSelectedColor = NSColor.theme

//        btn.backgroundColor = NSColor.red
//        btn.titleColor = NSColor.green
        
//        let attDic = NSAttributedString.attrDict(15, textColor: NSColor.red)
//        btn.attributedTitle = NSAttributedString(string: "UIButton", attributes: attDic)

//        item.view.getViewLayer()
    } else if indexPath.item == 14 {
        item.btn.isHidden = true
        
        item.view.addSubview(btnOne)
        btnOne.center = CGPoint(x: 70, y: 70)
        
    } else if indexPath.item == 15 {
        item.btn.isHidden = true
       
        item.view.addSubview(btnTwo)
        btnTwo.center = CGPoint(x: 70, y: 70)
//        btnTwo.isEnabled = false;
    } else if indexPath.item == 16 {
         item.btn.isHidden = true
        
         item.view.addSubview(btnThree)
         btnThree.center = CGPoint(x: 70, y: 70)
        
    } else if indexPath.item == 17 {
        item.btn.isHidden = true
       
        DDLog(item.view.frame, item.view.bounds, item.view.center)
        item.view.addSubview(btnFour)
        btnFour.center = CGPoint(x: item.view.bounds.width*0.5, y: item.view.bounds.height*0.5)
       
   }
//    view.layer?.backgroundColor = NSColor.random.cgColor
//    view.getViewLayer()
    return item
  }
  
  func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
//    let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNHeaderFooterView"), for: indexPath) as! NNHeaderFooterView
    let view = collectionView.dequeueReusableSupplementaryView(for: NNHeaderFooterView.self, kind: NSCollectionView.elementKindSectionHeader, indexPath: indexPath)
    view.textField.stringValue = "Section \(indexPath.section)"
    view.textFieldDetail.stringValue = "\(indexPath.item) image files"
    return view
  }
  
}

extension NNButtonStyleController : NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print(indexPaths)
    }
}

extension NNButtonStyleController : NSCollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
    return singleSectionMode ? NSZeroSize : NSSize(width: collectionView.frame.width, height: 40)
  }
}

