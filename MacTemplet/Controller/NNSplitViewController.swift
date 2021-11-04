//
//  NNSplitViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/8.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNSplitViewController: NSViewController {
    
    lazy var splitView: NSSplitView = {
        let splitView = NSSplitView(frame: view.bounds)
        splitView.autoresizesSubviews = true
        splitView.autoresizingMask = [.width, .height]
        
        splitView.wantsLayer = true
        splitView.layer?.backgroundColor = NSColor.cyan.cgColor
        // 设置分割方向 isVertical  =true 垂直分割 =false 水平分割
        splitView.isVertical = true
        /**设置分割样式
        thin  不同分割区域中间夹着一根线
        thick 不同分割区域中间夹着一个原点
        paneSplitter 不同分割区域夹着paneSplitter 分割块,分割块中也有一个原点
        */
        splitView.dividerStyle = .thin
        return splitView
    }()
    
    
    lazy var view1: NSView = {
        let view = NSView(frame: NSRect.zero)
        view.autoresizingMask = .none
        view.autoresizesSubviews = true
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightBlue.cgColor
        return view
    }()
    
    lazy var view2: NSView = {
        let view = NSView(frame: NSRect.zero)
        view.autoresizingMask = .none
        view.autoresizesSubviews = true
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.lightGreen.cgColor
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        splitView.delegate = self
        view.addSubview(splitView)
                   
        /** 添加视图 */
        splitView.addSubview(view1)
        splitView.addSubview(view2)
        
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        splitView.setPosition(NSWidth(view.bounds)*0.2, ofDividerAt: 0)
    }
    
}

extension NNSplitViewController: NSSplitViewDelegate {

    //只允许左边视图拉伸移动
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        if subview == splitView.subviews[0] {
            return true
        }
        return false
    }

    //向左移动拉伸距离最小为30
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return NSWidth(view.bounds)*0.1
    }

    //向右移动拉伸最大值为100
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return NSWidth(view.bounds)*0.9
    }

    //允许调整子视图
    func splitView(_ splitView: NSSplitView, shouldAdjustSizeOfSubview view: NSView) -> Bool {
        return true
    }

    //调整子视图大小
    func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {

    }

    //允许拉伸移动子视图最小化后隐藏分割线
    func splitView(_ splitView: NSSplitView, shouldHideDividerAt dividerIndex: Int) -> Bool {
        return true
    }

    //视图Size变化的通知
    func splitViewDidResizeSubviews(_ notification: Notification) {

    }

    func splitViewWillResizeSubviews(_ notification: Notification) {

    }

}
