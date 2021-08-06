//
//  OtherConvertController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/7/16.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

class OtherConvertController: NSViewController {
    
    lazy var imageView: NSImageView = {
        let view = NSImageView(frame:NSRect(x: 20, y: 20, width: 200, height: 200))
        view.layer?.backgroundColor = NSColor.lightGreen.cgColor
        return view
    }()

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addSubview(imageView)
//        imageView.addGestureRotation { gesture in
//            DDLog(gesture.rotation)
//        }
        
//        let obj = NSRotationGestureRecognizer(target: self, action: #selector(handleRotation(_:)))
//        view.addGestureRecognizer(obj)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
                
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        convert(content, name: "hContent", type: "dart") {
"""
\tif (this == Colors.\($0)) {
\t\treturn "\($0)";
\t}
"""
        }
    }
    
    func convert(_ text: String, name: String, type: String, transform: (String) -> String) {
        let list: [String] = text.components(separatedBy: "\n")
        DDLog(list.count)
                
        let content = list.map(transform).joined(separator: "\n")
        FileManager.createFile(content: content, name: name, type: type)
    }
    
    @objc func handleRotation(_ gesture: NSRotationGestureRecognizer) {
        DDLog(gesture.rotation)
    }

}


fileprivate let content = """
pink
purple
deepPurple
indigo
blue
lightBlue
cyan
teal
green
lightGreen
lime
yellow
amber
orange
deepOrange
brown
grey
blueGrey
redAccent
pinkAccent
purpleAccent
deepPurpleAccent
indigoAccent
blueAccent
lightBlueAccent
cyanAccent
tealAccent
greenAccent
lightGreenAccent
limeAccent
yellowAccent
amberAccent
orangeAccent
deepOrangeAccent
"""
