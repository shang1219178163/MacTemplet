//
//  NSVisualEffectController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/24.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@available(OSX 10.14, *)
class NSVisualEffectController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor;
        
        let imgViewRect = CGRectMake(10, 10, view.bounds.size.width, view.bounds.size.height*0.5)
        let imgView = NSImageView(frame: imgViewRect)
        imgView.image = NSApplication.appIcon
        view.addSubview(imgView)
        
        let rect = CGRectMake(10, 10, view.bounds.size.width*0.5, view.bounds.size.height*0.5)
        view.addVisualEffectView(rect)
        
        

    }
    
}
