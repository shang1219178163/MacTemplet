//
//  TmpViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import CoreFoundation

class TmpViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor
        
        let click = NSClickGestureRecognizer();
        view.addGestureRecognizer(click)
//        click.addAction { (reco) in
//            DDLog(reco);
//        }
        
        click.addAction {
            DDLog("click");
        }
        
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
           
        DDLog(NNClassFromString("QAZViewController"))
    }
    

}

