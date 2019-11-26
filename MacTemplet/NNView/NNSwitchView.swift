//
//  NNSwitchView.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

class NNSwitchView: NSView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
//      lazy var labelLeft: N = {
//          var view = UILabel(frame: .zero);
//          view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//          view.textAlignment = .left;
//          view.numberOfLines = 0;
//          view.lineBreakMode = .byCharWrapping;
//          view.isUserInteractionEnabled = true;
//    
//          return view;
//      }()
//    
//      lazy var labelLeft: UILabel = {
//          var view = UILabel(frame: .zero);
//          view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//          view.textAlignment = .left;
//          view.numberOfLines = 0;
//          view.lineBreakMode = .byCharWrapping;
//          view.isUserInteractionEnabled = true;
//    
//          return view;
//      }()
}
