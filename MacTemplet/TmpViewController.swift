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
#if (DEBUG)
    print("Test Coding");
#endif
        
#if DEBUG
    print("TmpViewController_测试模式")
#else
    print("TmpViewController_release模式")

#endif
        
        let click = NSClickGestureRecognizer();
        view.addGestureRecognizer(click)
        click.addAction { (reco) in
            DDLog(reco);
        }
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        let cls = NSClassFromString("AuthorInfoController")
        let clsOne = NSClassFromString("AuthorInfoController1")
        let clsTwo = NSClassFromString("MacTemplet.TmpViewController")
        let clsThree = NSClassFromString("TmpViewController")

        DDLog(cls, clsOne, clsTwo, clsThree)

//        if let cls = NSClassFromString("MacTemplet.TmpViewController") {
//            if let result: String = NSStringFromClass(cls) {
//                DDLog(result)
//            } else {
//                DDLog("111")
//            }
//        } else {
//            DDLog("OC 类不存在, 若是swift文件为:'命名空间.类名'")
//        }
//        let isExsit = FileManager.isExistFile(name: "TmpViewController", isSwift: true)
        
        DDLog(NNClassFromString("QAZViewController"))
    }
    

}

