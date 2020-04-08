//
//  BookListController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/8.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

class BookListController: NSViewController {
    
    lazy var outlineView: NNOutlineView = {
        let view = NNOutlineView(frame: .zero)
        view.floatsGroupRows = false
        view.allowsColumnResizing = true;
        view.dataSource = self
        view.delegate = self
        ///只有sourceList 现实 Show/Hide
//        view.selectionHighlightStyle = .sourceList
        view.headerView = nil

        let column = NSTableColumn.create(identifier: "TextCell", title: "目录")
        view.addTableColumn(column)
        
        return view
    }()

    var images: [NSImage] = [NSImage(named: NSImage.iconViewTemplateName)!,
                             NSImage(named: NSImage.homeTemplateName)!,
                             NSImage(named: NSImage.quickLookTemplateName)!,
                             NSImage(named: NSImage.slideshowTemplateName)!, ]
    
    var topLevelItems = ["Favorites", "Content Views", "Mailboxes", "A Fourth Group",]

    var dic: [String: Any] = [:]
    var list: [NNTreeNodelModel] = []

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        for e in topLevelItems.enumerated() {
            let model = NNTreeNodelModel()
            model.name = e.element

            var array: [NNTreeNodelModel] = []
            for i in 0..<(e.offset) {
                let childModel = NNTreeNodelModel()
                childModel.parent = model
                childModel.name = e.element + "\(i)"
                array.append(childModel)
            }
            model.childs = array
            list.append(model)
        }
        
        view.addSubview(outlineView.enclosingScrollView!)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        outlineView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
//        outlineView.enclosingScrollView!.frame = view.bounds
        outlineView.enclosingScrollView!.frame = CGRectMake(0, 0, NSWidth(view.bounds)*0.4, NSHeight(view.bounds))
    }
    
    @objc func handleAction(_ sender: NSButton) {
        DDLog(sender.title)
    }
    
}

//MARK: - NSOutlineViewDelegate
extension BookListController: NSOutlineViewDelegate {
    
    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        guard let it = item as? NNTreeNodelModel else { return 20 }
//        return it.parent == nil ? 20 : 30
        return it.parent == nil ? 30 : 30

    }
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let it = item as? NNTreeNodelModel else { return nil }
        if it.parent == nil {
//            let identifier = NSUserInterfaceItemIdentifier(rawValue: "NSTextField")
//            var view = outlineView.makeView(withIdentifier: identifier, owner: self) as? NSTextField
//            if view == nil {
//                view = {
//                   // Create a text field for the cell
//                    let textField = NSTextField()
//                    textField.backgroundColor = NSColor.clear
////                    textField.translatesAutoresizingMaskIntoConstraints = false
//                    textField.isBordered = false
////                    textField.controlSize = .small
//                    textField.usesSingleLineMode = true
//                    textField.isEditable = false
//
//                    return textField
//                }()
//            }
//            view?.stringValue = it.name
//            return view
            
            let view = outlineView.makeView(for: NSTableCellViewOne.self, identifier: "NSTableCellViewOneHeader")
            view.imgView.isHidden = true
            view.button.isHidden = it.childs.count == 0
            view.button.title = outlineView.isItemExpanded(it) == true ? "hide" : "show"
            view.button.addActionHandler { (controll) in
                guard let sender = controll as? NSButton else { return }
//                DDLog(sender.title)
                if sender.title == "hide" {
                    outlineView.collapseItem(item, collapseChildren: true)
                    sender.title = "show"

                } else {
                    outlineView.expandItem(item, expandChildren: true)
                    sender.title = "hide"
                }
            }

            view.label.stringValue = it.name
            return view
        }
    
        let view = outlineView.makeView(for: NSTableCellViewOne.self)
        view.label.stringValue = it.name
        view.imgView.image = images.first
        
        view.button.title = "42"
        view.button.addTarget(self, action: #selector(handleAction(_:)))
//        view.button.isHidden =
        view.getViewLayer()
        return view
    }
        
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        let row = outlineView.selectedRow
        if let item = outlineView.item(atRow: row) as? NNTreeNodelModel {
            if item.parent == nil {
                print("\(#function):\(item.name)_\(item.childs.count)")
                
                if outlineView.isItemExpanded(item) {
                    outlineView.collapseItem(item, collapseChildren: true)
                }  else {
                    outlineView.expandItem(item, expandChildren: true)
                }

            } else {
                print("\(#function):\(item.name)")
            }
        }
    }

}

//MARK: - NSOutlineViewDataSource
extension BookListController: NSOutlineViewDataSource {
    
   func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        guard let it = item as? NNTreeNodelModel else { return list.count }
        print("\(#function):\(it.childs.count)")
        return it.childs.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        guard let it = item as? NNTreeNodelModel else { return list[index] }
        print("\(#function):\(it.childAtIndex(index)?.name)")
        return it.childAtIndex(index)!
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        guard let it = item as? NNTreeNodelModel else { return false }
        return it.childs.count > 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        guard let it = item as? NNTreeNodelModel else { return false }
        return it.childs.count > 0
    }

}


