//
//  TmpViewController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import CoreFoundation
import CocoaExpand
import NNButton

import Quartz

class TmpViewController: NSViewController {
    
    lazy var flowLayout: NSCollectionViewFlowLayout = {
        let layout = NSCollectionViewFlowLayout()
        layout.itemSize = NSSize(width: 160.0, height: 140.0)
        layout.sectionInset = NSEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        layout.minimumInteritemSpacing = 20.0
        layout.minimumLineSpacing = 20.0
        layout.sectionHeadersPinToVisibleBounds = true
        return layout
    }()
    
    lazy var collectionView: NNCollectionView = {
        let collectionView = NNCollectionView(frame: self.view.bounds)
        collectionView.collectionViewLayout = flowLayout
        collectionView.isSelectable = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        collectionView.register(NNCollectionViewItem.classForCoder(), forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNCollectionViewItem"))
//        collectionView.register(NNHeaderFooterView.classForCoder(), forSupplementaryViewOfKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNHeaderFooterViewHeader"))
        collectionView.register(cellType: NNCollectionViewItem.self)
        collectionView.register(supplementaryViewType: NNHeaderFooterView.self)
        self.view.wantsLayer = true
        collectionView.layer?.backgroundColor = NSColor.black.cgColor
        return collectionView
    }()
    
    var list: [String] = ["action", "action", "action", "action", "action"]
    
    lazy var windowCtrl: NSWindowController = {
        let controller = UUTabViewController()
        let windowCtrl = NSWindowController(window: NSWindow.create(controller: controller))
        return windowCtrl
    }()
        
    
    // MARK: -life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
                
        view.addSubview(collectionView.enclosingScrollView!)
        collectionView.reloadData()
        
//        view.getViewLayer()
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        collectionView.enclosingScrollView!.frame = view.bounds
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
//        DDLog(btnTwo.value(forKey: "mdicHighlighted"))
    }
    
    // MARK: -funtions
    @objc func handleAction(_ sender: NSButton) {
        switch sender.tag {
        case 0:
            windowCtrl.showWindow(sender)

        default:
            break
        }
    }
    
}

extension TmpViewController : NSCollectionViewDataSource {
  
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 1
    }
  
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
  
    func collectionView(_ itemForRepresentedObjectAtcollectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    
//    let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNCollectionViewItem"), for: indexPath)
    guard let item = collectionView.dequeueReusableCell(for: NNCollectionViewItem.self, indexPath: indexPath) as NNCollectionViewItem? else {
        return NSCollectionViewItem()
    }

    item.textLabel.isHidden = true
    item.textLabelBottom.stringValue = "{\(indexPath.section),\(indexPath.item)}"
    item.textLabelBottom.alignment = .center
    item.btn.tag = indexPath.item;
        
    item.btn.addTarget(self, action: #selector(handleAction(_:)))
    
//    view.layer?.backgroundColor = NSColor.random.cgColor
//    view.getViewLayer()
        return item
    }
  
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
    //    let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NNHeaderFooterView"), for: indexPath) as! NNHeaderFooterView
        let view = collectionView.dequeueReusableSupplementaryView(for: NNHeaderFooterView.self, kind: NSCollectionView.elementKindSectionHeader, indexPath: indexPath)
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.textField.stringValue = "Section \(indexPath.section)"
    //    view.textFieldDetail.stringValue = "\(indexPath.item) image files"
            
        view.textField.stringValue = indexPath.section == 0 ? "官方样式" : "自定义按钮"
        return view
    }

}

extension TmpViewController : NSCollectionViewDelegate {
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        print(indexPaths)
    }
}

extension TmpViewController : NSCollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize{
        return NSSize(width: collectionView.frame.width, height: 25)
    }
}

