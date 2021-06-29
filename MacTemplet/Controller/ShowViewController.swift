//
//  ShowViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/4.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

class ShowViewController: NSViewController {

    var itemList: [NSButton] = []

    var isChoose = false
    
    var vcOne = BlueViewController()
    var vcTwo = GreenViewController()
    var vcThree = OrangeViewController()
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let list: [String] = ["Next", "Front", "AsSheet", "AsModal", "asPopover", "Button", ]
        itemList = list.enumerated().map({ (e) -> NSButton in
            let sender = NSButton(title: e.element, target: self, action: #selector(handleAction(_:)))
            sender.bezelStyle = .regularSquare
            sender.lineBreakMode = .byCharWrapping
            sender.tag = e.offset
            return sender
        })
        
        itemList.forEach { (e) in
            view.addSubview(e)
        }
//        DDLog(view.frame, view.bounds)
//        view.getViewLayer()
        
        addChild(vcOne)
        addChild(vcTwo)
                
        view.addSubview(vcOne.view)
        view.addSubview(vcTwo.view)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.1)
        itemList.updateItemsConstraint(frame, numberOfRow: 6)
//        print("\(#function)_\(view.bounds.size)_\(vcOne.view.bounds.size)")

        for e in children.enumerated() {
            e.element.view.frame = CGRectMake(40, frame.maxY, view.bounds.width - 80, view.bounds.height - frame.maxY)
        }
    }
    
    // MARK: -funtions
    @objc func handleAction(_ sender: NNButton) {
//        DDLog("\(sender.tag)")

        switch sender.tag {
        case 0:
            if children[0].view.superview == nil {
                return
            }
            transition(from: children[0], to: children[1], options: .slideLeft, completionHandler: nil)

        case 1:
            if children[1].view.superview == nil {
                return
            }
            transition(from: children[1], to: children[0], options: .slideRight, completionHandler: nil)

        case 2:
            presentAsSheet(vcOne)
            
        case 3:
            DDLog("\(presentingViewController)\(presentedViewControllers)")
//            if presentedViewControllers?.count != 0 {
//                dismiss(vcOne)
//                dismiss(presentedViewControllers?.last)
//                return
//            }
            //问题: dismiss时presentedViewControllers不会减少
            presentAsModalWindow(vcOne)
            
        case 4:
            DDLog("\(presentingViewController)\(presentedViewControllers)")
            if vcThree.presentingViewController != nil{
                dismiss(vcThree)
                return
            }
            vcThree.preferredContentSize = CGSize(width: 300, height: 300)
            present(vcThree, asPopoverRelativeTo: view.frame, of: sender, preferredEdge: .maxY, behavior: .semitransient)
        default:
            break;
        }
    }
}
