//
//  NSOutlineViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SnapKit

class NSOutlineViewController: NSViewController {
    
    lazy var outlineView: NNOutlineView = {
        let view = NNOutlineView(frame: .zero)
        view.floatsGroupRows = false
        view.allowsColumnResizing = true;
        view.dataSource = self
        view.delegate = self
        
        let column = NSTableColumn.create(identifier: "TextCell", title: "目录")
        view.addTableColumn(column)

        return view
    }()

    fileprivate var rootItem: FileItem? = FileItem.rootItem

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(outlineView.enclosingScrollView!)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        outlineView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        outlineView.enclosingScrollView!.frame = view.bounds
        
//        for column in outlineView.tableColumns {
//            column.width = view.bounds.width/CGFloat(outlineView.tableColumns.count);
//        }

    }
    
}

//MARK: - NSOutlineViewDelegate
extension NSOutlineViewController: NSOutlineViewDelegate {
    
    
  func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
      // If errors try with
        let identifier = NSUserInterfaceItemIdentifier(rawValue: "TextCell")
      // let view = outlineView.make(withIdentifier: "TextCell", owner: self) as? NSTableCellView
        var view = outlineView.makeView(withIdentifier: identifier, owner: self) as? NSTableCellView
        if view == nil {
            view = {
                // Create a text field for the cell
                let textField = NSTextField()
                textField.backgroundColor = NSColor.clear
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.isBordered = false
                textField.controlSize = .small
                
                let newCell = NSTableCellView()
                newCell.identifier = identifier
                newCell.addSubview(textField)
                newCell.textField = textField
                
                textField.frame = newCell.bounds
 
                return newCell
            }()
        }
        if let it = item as? FileItem {
            if let textField = view?.textField {
                textField.isEditable = false
                textField.stringValue = it.displayName
            }
        }

//        view?.getViewLayer()
        return view
    }
        
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else { return }
        let row = outlineView.selectedRow
        if let item = outlineView.item(atRow: row) as? FileItem {
            print("\(#function):\(item.displayName)")
        }
    }
}

//MARK: - NSOutlineViewDataSource
extension NSOutlineViewController: NSOutlineViewDataSource {
    
   func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        guard let it = item as? FileItem else { return 1 }
//        print("\(#function):\(it.count)")
        return it.count
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        guard let it = item as? FileItem else { return rootItem as Any }
        return it.childAtIndex(index)!
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        guard let it = item as? FileItem else { return false }
        return it.count > 0
    }
    
    func outlineView(_ outlineView: NSOutlineView, isGroupItem item: Any) -> Bool {
        guard let it = item as? FileItem else { return false }
        return it.count > 0
    }

//    func outlineView(_ outlineView: NSOutlineView, shouldShowOutlineCellForItem item: Any) -> Bool {
//        return true
//    }

}


