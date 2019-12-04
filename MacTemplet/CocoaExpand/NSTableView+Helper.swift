
//
//  NSTableView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSTableView {

    static func create(_ rect: CGRect) -> Self {
        let view: NSTableView = self.init(frame: rect);
        view.autoresizingMask = [.width, .height];
           
        view.gridStyleMask = .solidVerticalGridLineMask
        view.focusRingType = .none //tableview获得焦点时的风格
        view.selectionHighlightStyle = .regular //行高亮的风格
        view.layer?.backgroundColor = NSColor.background.cgColor
        view.usesAlternatingRowBackgroundColors = false //背景颜色的交替，一行白色，一行灰色。设置后，原来设置的 backgroundColor 就无效了。
//        view.gridColor = NSColor.red
        
        view.appearance = NSAppearance(named: .aqua)
        view.headerView = nil;
        view.rowHeight = 70;

        return view as! Self;
    }
    
    /// 添加一组表头
    func addTableColumn(titles: [String]) {
      for e in titles {
          let column = NSTableColumn.create(identifier: e, title: e)
          self.addTableColumn(column)
      }
      
    }
    
}
