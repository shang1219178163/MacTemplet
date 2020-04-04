//
//  ShowViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/4.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import CocoaExpand

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
        itemList = NSButton.createGroupView(.zero, list: list, numberOfRow: 6, padding: 8, target: self, action: #selector(handleAction(_:)), inView: view);
        
        addChild(vcOne)
        addChild(vcTwo)
                
        view.addSubview(vcOne.view)
        view.addSubview(vcTwo.view)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height*0.1)
        NSButton.setupConstraint(frame, items: itemList, numberOfRow: 6, padding: 8)
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

            if presentedViewControllers?.count != 0 {
                dismiss(vcThree)
                return
            }
            
            present(vcThree, asPopoverRelativeTo: view.frame, of: sender, preferredEdge: .maxY, behavior: .semitransient)
        default:
            break;
        }
    }
}
