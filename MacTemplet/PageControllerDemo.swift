//
//  PageControllerDemo.swift
//  MacTemplet
//
//  Created by shangbinbin on 2021/11/5.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SnapKit
import SwiftExpand

class PageControllerDemo: NSViewController {
    
    let inset = EdgeInsets(0, 10, 10, 10)
    
    let tuples = [("one", NSViewController(color: NSColor.systemGreen)),
                 ("two", NSViewController(color: NSColor.systemRed)),
                 ("three", NSViewController(color: NSColor.systemYellow)),
                ("four", NSViewController(color: NSColor.systemBlue))
    ]
    
    lazy var pageVC: NSPageController = {
        let vc = NSPageController()
        return vc
    }()
    
    lazy var segmentCtl: NSSegmentedControl = {
        let view = NSSegmentedControl(frame: .zero)
        view.items = tuples.map({ $0.0 })

        view.addActionHandler({ sender in
            DDLog(sender.selectedSegment)
            self.change(sender.selectedSegment, isAnimator: true)

        }, trackingMode: .selectOne)
        return view;
    }()


    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageVC.delegate = self
        pageVC.arrangedObjects = tuples
        
        view.addSubview(segmentCtl)
        view.addSubview(pageVC.view)

        segmentCtl.selectedSegment = 0
    }
        
    override func viewDidAppear() {
        super.viewDidAppear()
        
        segmentCtl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(inset.top)
            make.left.equalToSuperview().offset(inset.left)
            make.right.equalToSuperview().offset(-inset.right)
            make.height.equalTo(40)
        }
        
        pageVC.view.snp.remakeConstraints { make in
            make.top.equalTo(segmentCtl.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(inset.left)
            make.right.equalToSuperview().offset(-inset.right)
            make.bottom.equalToSuperview().offset(-inset.bottom)
        }
    }
    

    func change(_ index: Int, isAnimator: Bool = false) {
        if isAnimator {
            pageVC.animator().selectedIndex = index
        } else {
            pageVC.selectedIndex = index
        }
        DDLog(pageVC.selectedIndex)
//            navigateForward(arrangedObjects[selectedIndex])
    }
}

extension PageControllerDemo: NSPageControllerDelegate {
    
    func pageController(_ pageController: NSPageController, viewControllerForIdentifier identifier: String) -> NSViewController {
        let vc = tuples[pageController.selectedIndex].1
        return vc
    }

    func pageController(_ pageController: NSPageController, identifierFor object: Any) -> String {
        let e = tuples[pageController.selectedIndex].0
        return e
    }

//    func pageController(_ pageController: NSPageController, prepare viewController: NSViewController, with object: Any?) {
//
//    }

    func pageControllerDidEndLiveTransition(_ pageController: NSPageController) {
        pageController.completeTransition()
    }
}

extension NSViewController{
    
    convenience init(color: NSColor) {
        self.init()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = color.cgColor
    }
}
