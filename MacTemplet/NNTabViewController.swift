//
//  NNTabViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/31.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

class NNTabViewController: NSWindowController {

//    var toolbar: NSToolbar?
    lazy var toolbar: NSToolbar = {
        let toolbar = NSToolbar(identifier:"ScreenNameToolbarIdentifier")
        toolbar.allowsUserCustomization = true
        toolbar.delegate = self
        return toolbar
    }()
    
    let toolbarItems: [[String: String]] = [
        ["title": "irrelevant :)", "icon": "", "identifier": "NavigationGroupToolbarItem"],
        ["title": "Share", "icon": NSImage.shareTemplateName, "identifier": "ShareToolbarItem"],
        ["title": "Add", "icon": NSImage.addTemplateName, "identifier": "AddToolbarItem"],
        ["title": "Departments",
         "icon": "NSPreferencesGeneral",
         "identifier": "DepartmentViewController"],
        ["title": "Accounts",
         "icon": "NSFontPanel",
         "identifier": "AccountViewController"],
        ["title": "Employees",
         "icon": "NSAdvanced",
         "identifier": "EmployeeViewController"],
        ["title": "", "icon": "", "identifier": "NNUserInfoView"],
    ]

    var toolbarTabsIdentifiers: [NSToolbarItem.Identifier] {
        var list = toolbarItems.compactMap { $0["identifier"] }.map{ NSToolbarItem.Identifier(rawValue: $0) }
        list.insert(NSToolbarItem.Identifier.flexibleSpace, at: 3)
        list.insert(NSToolbarItem.Identifier.flexibleSpace, at: list.count - 1)
//        list.append(NSToolbarItem.Identifier.flexibleSpace)
        return list
    }
    
    var currentVC: NSViewController!

    var currentIdentifier = ""
    
    // MARK: -lifecycle
    
    override init(window: NSWindow?) {
        super.init(window: window)
        
//        toolbar = NSToolbar(identifier:"ScreenNameToolbarIdentifier")
//        toolbar?.displayMode = .iconAndLabel
//        toolbar?.allowsUserCustomization = true
//        toolbar?.delegate = self
        window?.toolbar = toolbar
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        // Do view setup here.
    }
    
    // MARK: -funtions
    @objc func handleSegmentSelected(_ sender: NSSegmentedControl){
        print("\(#function):\(sender.selectedSegment)")

    }
    
    @objc func handleBtnSelected(_ sender: NSButton){
        print("\(#function):\(sender)")

    }
    
    @objc func handleItemSelected(_ sender: NSToolbarItem){
        print("\(#function):\(sender.itemIdentifier.rawValue)_\(sender.label)")
        loadViewWithIdentifier(itemIdentifier: sender.itemIdentifier.rawValue, withAnimation: true)

    }
    
    @objc func handleViewSelected(_ sender: NNUserInfoView){
        print("\(#function):\(sender)")

    }
        
    func loadViewWithIdentifier(itemIdentifier: String, withAnimation shouldAnimate:Bool){
        let VCIdentifiers: [String] = ["DepartmentViewController", "AccountViewController", "EmployeeViewController"]
        if VCIdentifiers.contains(itemIdentifier) == false {
            return
        }
        
//        print("\(#function):\(itemIdentifier)")
        if (currentIdentifier == itemIdentifier){
            return
        }
        currentIdentifier = itemIdentifier
        
        guard let itemDict: [String : String] = toolbarItems.filter({ $0["identifier"] == itemIdentifier }).first
            else { return }

        if (itemIdentifier == "DepartmentViewController"){
            currentVC = DepartmentViewController()

        }
        else if (itemIdentifier == "AccountViewController"){
            currentVC = AccountViewController()

        }
        else if (itemIdentifier == "EmployeeViewController"){
            currentVC = EmployeeViewController()
        }
                
        guard let window = self.window else { return }
//        print(currentVC as Any)
        let newView = currentVC.view
        
        let windowRect = window.frame
        let currentViewRect = newView.frame
        
//        print(windowRect as Any)
        
        let originY = windowRect.origin.y + (windowRect.size.height - currentViewRect.size.height)
        let newFrame = NSMakeRect(windowRect.origin.x, originY, currentViewRect.size.width, currentViewRect.size.height)

        window.title = currentVC.title ?? itemDict["title"]!;
        window.contentView = newView
        window.setFrame(newFrame, display: true, animate: shouldAnimate)
    }

    
    lazy var popover: NSPopover = {
        let controller = ListViewController()
        controller.preferredContentSize = CGSize(width: kScreenWidth*0.15, height: kScreenHeight*0.25)
        let popView = NSPopover.create(controller: controller)
        return popView
    }()

    func showPopoverController(_ sender: NSView) {
        popover.show(sender, preferredEdge: .maxY)
    }
    
}

extension NNTabViewController: NSToolbarDelegate{
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {

        guard let itemDict: [String : String] = toolbarItems.filter({ $0["identifier"] == itemIdentifier.rawValue }).first
            else { return nil }

        let toolbarItem: NSToolbarItem

        if itemIdentifier.rawValue == "NavigationGroupToolbarItem" {

            let group = NSToolbarItemGroup(itemIdentifier: itemIdentifier)

            let itemA = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: "PrevToolbarItem"))
            itemA.label = "Prev"
            let itemB = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: "NextToolbarItem"))
            itemB.label = "Next"

//            let segmented = NSSegmentedControl(frame: NSRect(x: 0, y: 0, width: 85, height: 40))
//            segmented.segmentStyle = .texturedRounded
//            segmented.trackingMode = .momentary
//
//            segmented.segmentCount = 2
//            // Don't set a label: these would appear inside the button
//            segmented.setImage(NSImage(named: NSImage.goBackTemplateName)!, forSegment: 0)
//            segmented.setWidth(40, forSegment: 0)
//            segmented.setImage(NSImage(named: NSImage.goForwardTemplateName)!, forSegment: 1)
//            segmented.setWidth(40, forSegment: 1)
            let items: [Any] = [NSImage(named: NSImage.goBackTemplateName)!, NSImage(named: NSImage.goForwardTemplateName)!, ]
            let segmented = NSSegmentedControl.create(NSRect(x: 0, y: 0, width: items.count*40, height: 40), items: items)
            segmented.target = self
            segmented.action = #selector(handleSegmentSelected(_:))

            // `group.label` would overwrite segment labels
            group.paletteLabel = "Navigation"
            group.subitems = [itemA, itemB]
            group.view = segmented

            toolbarItem = group
        } else if ["ShareToolbarItem", "AddToolbarItem"].contains(itemIdentifier.rawValue) {


            let iconImage = NSImage(named: itemDict["icon"]!)
            let button = NSButton(frame: NSRect(x: 0, y: 0, width: 40, height: 40))
            button.title = ""
            button.image = iconImage
            button.bezelStyle = .texturedRounded
            button.target = self
//            button.action = #selector(handleBtnSelected(_:))
            button.action = Selector(("handleBtnSelected:"))

            toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.label = itemDict["title"]!
            toolbarItem.view = button
            
        } else if ["NNUserInfoView", ].contains(itemIdentifier.rawValue) {
            
            let userView = NNUserInfoView(frame: NSRect(x: 0, y: 0, width: 160, height: 50))
            userView.name = "SoaringHeart"
            userView.desc = "装逼或者被装逼。"
            userView.delegate = self
            
            toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.label = itemDict["title"]!
            toolbarItem.target = self
            toolbarItem.action = #selector(handleViewSelected(_:))
            toolbarItem.view = userView
                
        }  else {
            let iconImage = NSImage(named: itemDict["icon"]!)
            
            toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
            toolbarItem.label = itemDict["title"]!
            toolbarItem.image = iconImage
            toolbarItem.target = self
            toolbarItem.action = #selector(handleItemSelected(_:))
        }
        return toolbarItem
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarTabsIdentifiers;
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return self.toolbarDefaultItemIdentifiers(toolbar)
    }

    func toolbarWillAddItem(_ notification: Notification) {
        print("toolbarWillAddItem", (notification.userInfo?["item"] as? NSToolbarItem)?.itemIdentifier ?? "")
    }

    func toolbarDidRemoveItem(_ notification: Notification) {
        print("toolbarDidRemoveItem", (notification.userInfo?["item"] as? NSToolbarItem)?.itemIdentifier ?? "")
    }
    
}


extension NNTabViewController: NSToolbarItemValidation{
    
    func validateToolbarItem(_ item: NSToolbarItem) -> Bool {
        return true
    }
}

extension NNTabViewController: NNUserInfoViewDelegate{

    func userInfoView(_ userView: NNUserInfoView, state: NSResponder.MouseState, event: NSEvent) {
        switch state {
        case .entered:
            print("\(#function):进入区域")
            showPopoverController(userView)
            
        case .exited:
            print("\(#function):离开区域")
            
        case .down:
            print("\(#function):点击")
        case .up:
            print("\(#function):抬起")
        default:
            break
        }
    }
}
