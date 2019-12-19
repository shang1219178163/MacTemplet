//
//  NSTableCellView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSTableCellView {

    /// 复用NSTableCellView
    static func makeView(tableView: NSTableView, identifier: String = String(describing: self), owner: Any) -> Self {
        if let view: NSTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), owner: owner) as? NSTableCellView {
            return view as! Self;
        }
        let cellView = self.init()
        cellView.identifier = NSUserInterfaceItemIdentifier(rawValue: identifier);
        cellView.wantsLayer = true;
        return cellView;
    }
    
    func udpateSelectionHighlight() {
        textField?.textColor = backgroundStyle == .dark ? NSColor.white : NSColor.black;
    }
    
}

public extension NSTableView {
    /// makeView
    final func makeView<T: NSTableCellView>(for cellType: T.Type, identifier: String = String(describing: T.self), style: NSTableView.RowSizeStyle = .default) -> T {
        if let view: NSTableCellView = makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), owner: T.self) as? T {
            return view as! T;
        }
        let cellView = T.init()
        cellView.identifier = NSUserInterfaceItemIdentifier(rawValue: identifier);
        cellView.wantsLayer = true;
        return cellView;
    }
}
