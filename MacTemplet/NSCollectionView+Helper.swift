//
//  NSCollectionView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/15.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

extension NSCollectionView {

    static let elementKindSectionItem: String = "UICollectionView.elementKindSectionItem";
    static let sectionKindBackgroud: String = "UICollectionView.sectiinKindBackgroud";
    
}


public extension NSCollectionView{

    /// 泛型复用register cell - Type: "类名.self" (备用默认值 T.self)
    final func register<T: NSCollectionViewItem>(cellType: T.Type, forItemWithIdentifier identifier: String = String(describing: T.self)){
        register(cellType.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier))
    }

    /// 泛型复用register supplementaryView - Type: "类名.self" (备用默认值 T.self)
    final func register<T: NSView>(supplementaryViewType: T.Type, ofKind elementKind: String = NSCollectionView.elementKindSectionHeader){
        guard elementKind.contains("KindSection") else {
            return;
        }
        let kindSuf = elementKind.components(separatedBy: "KindSection").last;
        let identifier = String(describing: T.self) + kindSuf!;
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier))

    }
    
    /// 泛型复用cell - cellType: "类名.self" (默认identifier: 类名字符串)
    final func dequeueReusableCell<T: NSCollectionViewItem>(for cellType: T.Type, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T{
        let cell = self.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), for: indexPath)
        return cell as! T;
    }
    
    /// 泛型复用SupplementaryView - cellType: "类名.self" (默认identifier: 类名字符串 + Header/Footer)
    final func dequeueReusableSupplementaryView<T: NSView>(for cellType: T.Type, kind: String, indexPath: IndexPath) -> T{
        let kindSuf = kind.components(separatedBy: "KindSection").last;
        let identifier = String(describing: T.self) + kindSuf!;
        let view = self.makeSupplementaryView(ofKind: kind, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), for: indexPath)
        
        view.wantsLayer = true
        view.layer!.backgroundColor = kind == NSCollectionView.elementKindSectionHeader ? NSColor.green.cgColor : NSColor.yellow.cgColor;
        return view as! T;
    }
}
