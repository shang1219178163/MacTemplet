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
    
    
//    let kTitleHide = "hide"
//    let kTitleShow = "show"

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
        outlineView.enclosingScrollView!.frame = CGRect(x: 0, y: 0, width: NSWidth(view.bounds)*0.4, height: NSHeight(view.bounds))
    }
    
    @objc func handleAction(_ sender: NSButton) {
//        DDLog(sender.title)
    }
    
    @objc func handleActionGesture(_ sender: NSClickGestureRecognizer) {
//        DDLog(sender)
        
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
            let view = outlineView.makeView(for: NSTableCellViewOutlineHeader.self)
            view.imgView.isHidden = true
            view.detailButton.isHidden = (it.childs.count == 0)
            view.detailButton.title = "\(it.childs.count)"
 
            view.button.title = it.name
            view.button.addActionHandler { (sender) in
                guard sender is NSButton else { return }
//                DDLog(sender.title)
                outlineView.expandOrCollapseItem(item: item)
            }
            
//            view.getViewLayer()
            return view
        }
    
        let view = outlineView.makeView(for: NSTableCellViewOne.self)
        view.label.stringValue = it.name
        view.imgView.image = images.first
        
        view.button.title = "42"
        view.button.addTarget(self, action: #selector(handleAction(_:)))
//        view.getViewLayer()
        return view
    }
        
//    func outlineViewSelectionDidChange(_ notification: Notification) {
//        guard let outlineView = notification.object as? NSOutlineView else { return }
//        let row = outlineView.selectedRow
//
//        if let item = outlineView.item(atRow: row) as? NNTreeNodelModel {
//            let isItemExpanded = outlineView.isItemExpanded(item)
////            DDLog(row, isItemExpanded)
//
//            if item.parent == nil {
//                print("\(#function):\(item.name)_\(item.childs.count)")
//                
//                if isItemExpanded == true {
//                    outlineView.collapseItem(item, collapseChildren: true)
//                } else {
//                    outlineView.expandItem(item, expandChildren: true)
//                }
//
//            } else {
//                print("\(#function):\(item.name)")
//            }
//        }
//    }
//    
//    func outlineViewItemDidExpand(_ notification: Notification) {
//        guard let outlineView = notification.object as? NSOutlineView, let item = notification.userInfo?.values.first as? NNTreeNodelModel else { return }
//        let isItemExpanded = outlineView.isItemExpanded(item)
////        DDLog(item.name, isItemExpanded)
//
//        let row = outlineView.row(forItem: item)
//        guard let cell = outlineView.view(atColumn: 0, row: row, makeIfNecessary: false) as? NSTableCellViewOne else { return }
//        cell.button.title = kTitleHide
//    }
//
//    func outlineViewItemDidCollapse(_ notification: Notification) {
//        guard let outlineView = notification.object as? NSOutlineView, let item = notification.userInfo?.values.first as? NNTreeNodelModel else { return }
//        let isItemExpanded = outlineView.isItemExpanded(item)
////        DDLog(item.name, isItemExpanded)
//
//        let row = outlineView.row(forItem: item)
//        guard let cell = outlineView.view(atColumn: 0, row: row, makeIfNecessary: false) as? NSTableCellViewOne else { return }
//        cell.button.title = kTitleShow
//    }
    
}

//MARK: - NSOutlineViewDataSource
extension BookListController: NSOutlineViewDataSource {
    
   func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        guard let it = item as? NNTreeNodelModel else { return list.count }
//        print("\(#function):\(it.childs.count)")
        return it.childs.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        guard let it = item as? NNTreeNodelModel else { return list[index] }
//        print("\(#function):\(it.childAtIndex(index)?.name)")
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
