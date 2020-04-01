//
//  NSOutlineViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/1.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NSOutlineViewController: NSViewController {
    
    lazy var outlineView: NNOutlineView = {
        let view = NNOutlineView(frame: .zero)
        view.floatsGroupRows = false
        view.dataSource = self
        view.delegate = self
        
        let column = NSTableColumn.create(identifier: "TextCell", title: "1213")
        view.addTableColumn(column)
        return view
    }()

    fileprivate var rootItem: FileItem? = FileItem(url: URL(fileURLWithPath:"/"), parent: nil)

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(outlineView.enclosingScrollView!)
        
//        outlineView.reloadItem(rootItem, reloadChildren: true)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        outlineView.reloadData()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        outlineView.enclosingScrollView!.frame = view.bounds
    }
    
}

//MARK: - NSOutlineViewDelegate
extension NSOutlineViewController: NSOutlineViewDelegate {
  func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
      // If errors try with
      // let view = outlineView.make(withIdentifier: "TextCell", owner: self) as? NSTableCellView
        var view = outlineView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "TextCell"), owner: self) as? NSTableCellView
        if view == nil {
            view = {
                // Create a text field for the cell
                let textField = NSTextField()
                textField.backgroundColor = NSColor.clear
                textField.translatesAutoresizingMaskIntoConstraints = false
                textField.isBordered = false
                textField.controlSize = .small
                
                let newCell = NSTableCellView()
                newCell.identifier = NSUserInterfaceItemIdentifier(rawValue: "TextCell")
                newCell.addSubview(textField)
                newCell.textField = textField

                return newCell
            }()
        }
        if let it = item as? FileItem {
            if let textField = view?.textField {
                textField.stringValue = it.displayName
            }
        }
        print("\(#function):\(view?.textField?.stringValue)")
        return view
    }
}

//MARK: - NSOutlineViewDataSource
extension NSOutlineViewController: NSOutlineViewDataSource {
   func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if let it = item as? FileItem {
            print("\(#function):\(it.count)")
            return it.count
        }
        return 1
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let it = item as? FileItem {
            if it.count > 0 {
                print("\(#function):\(it.count)")
                return true
            }
        }
        return false
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if let it = item as? FileItem {
            return it.childAtIndex(index)!
        }
        return rootItem!
    }
}
