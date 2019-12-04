//
//  NSImageView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSImageView {

    static func create(_ rect: CGRect) -> Self {
        let view: NSImageView = self.init(frame: rect);
        view.imageFrameStyle = .photo
        view.imageScaling = .scaleNone
        view.imageAlignment = .alignCenter
        view.isEditable = true;//能否直接将图片拖到一个NSImageView类里
        view.allowsCutCopyPaste = true;//能否对图片内容进行剪切、复制、粘贴行操作
        return view as! Self;
    }
}
