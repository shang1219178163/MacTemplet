//
//  NSStackViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

class NSStackViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let images = [NSImage(named: "Skull.jpg"), NSImage(named: "Skull.jpg"), NSImage(named: "Skull.jpg")]
        
        for image in images {
            //创建并添加内部视图
            let imageView = NSImageView(image: image!)
            stackView.addArrangedSubview(imageView)
        }
         
        //将StackView添加到主视图中
        view.addSubview(stackView)

        view.getViewLayer()
    }
    
    override func viewWillLayout() {
        super.viewWillLayout()
         
//        let padding: CGFloat = 10
//        stackView.frame = view.bounds;
////        stackView.frame = CGRect(x: 0,
////                                 y: 0,
////                                 width: view.frame.width,
////                                 height: view.frame.height)
//        //内部视图水平排列
//        stackView.orientation = .vertical

    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        stackView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: view.frame.width,
                                 height: view.frame.height)
        
//        for e in stackView.subviews.enumerated() {
//            if e.offset == 0 {
////                e.element.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.2).isActive = true
//                e.element.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.1).isActive = true
//            }
//        }
        //内部视图水平排列
        stackView.orientation = .horizontal
        stackView.setSubViewMultiplier(0.2, at: 0)
        stackView.setSubViewMultiplier(0.2, at: 1)

    }
    
    lazy var stackView: NSStackView = {
        //创建StackView
        let stackView = NSStackView(frame: self.view.bounds)
        //设置子视图间隔
        stackView.spacing = 10
        //子视图的高度或宽度保持一致
        stackView.distribution = .fillEqually
  
        return stackView;
    }()

  
}

