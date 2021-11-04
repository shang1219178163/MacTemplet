//
//  NSTextView+Ext.swift
//  MacTemplet
//
//  Created by shangbinbin on 2021/11/3.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Foundation
import Highlightr

extension NSTextView{
    ///代码高亮
    func setHighlightedCode() {
        if self.string.isEmpty {
            return
        }
        guard let highlightr = Highlightr() else {
            return }
        highlightr.setTheme(to: "atom-one-dark")
        guard let highlightedCode = highlightr.highlight(self.string) else {
            return }
        self.textStorage?.setAttributedString(highlightedCode)
        self.backgroundColor = highlightr.theme.themeBackgroundColor
    }
}
