//
//  NSVisualEffectView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc extension NSVisualEffectView {
    
    @available(OSX 10.14, *)
    public static func create(_ rect: CGRect = .zero) -> NSVisualEffectView {
        let effectView = NSVisualEffectView(frame: rect)
        effectView.blendingMode = .behindWindow
        effectView.material = .underWindowBackground
        effectView.state = .active
//        effectView.appearance = NSAppearance(named: .vibrantDark)
        return effectView;
    }
    
}
