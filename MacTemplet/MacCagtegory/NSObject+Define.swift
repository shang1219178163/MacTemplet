//
//  NSObject+Define.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import Cocoa

// 定义数据类型(其实就是设置别名)
public typealias SwiftClosure = (AnyObject, AnyObject, Int) -> Void

public typealias ObjClosure = ((AnyObject) -> Void)
public typealias ViewClosure = ((NSClickGestureRecognizer?, NSView, NSInteger) -> Void)
public typealias ControlClosure = (NSControl) -> Void
public typealias RecognizerClosure = ((NSGestureRecognizer) -> Void)

public typealias CellHeightForRowClosure = ((NSTableView, IndexPath) -> CGFloat)
public typealias CellForRowClosure = ((NSTableView, IndexPath) -> NSTableCellView?)
public typealias DidSelectRowClosure = ((NSTableView, IndexPath) -> Void)
//
//public typealias CellForItemClosure = ((NSCollectionView, IndexPath) -> NSCollectionViewCell?)
public typealias DidSelectItemClosure = ((NSCollectionView, IndexPath) -> Void)

public typealias ScrollViewDidScrollClosure = ((NSScrollView) -> Void)

// MARK: - 关联属性的key
public struct RuntimeKey {
    public static let tap = UnsafeRawPointer(bitPattern: "tap".hashValue)!;
    public static let item = UnsafeRawPointer(bitPattern: "item".hashValue)!;
//    public static let control = UnsafeRawPointer(bitPattern: "control".hashValue)!;

}

public func RuntimeKeyParams(_ obj: NSObject!, funcAbount: String!) -> UnsafeRawPointer! {
    let unique = "\(obj.hashValue)," + funcAbount
    let key: UnsafeRawPointer = UnsafeRawPointer(bitPattern: unique.hashValue)!
    return key;
}

public func RuntimeKeyString(_ obj: String) -> UnsafeRawPointer! {
    let key: UnsafeRawPointer = UnsafeRawPointer(bitPattern: obj.hashValue)!
    return key;
}

public func RuntimeKeySelector(_ aSelector: Selector) -> UnsafeRawPointer! {
    let aSelectorName = NSStringFromSelector(aSelector);
    let key: UnsafeRawPointer = RuntimeKeyString(aSelectorName)
    return key;
}

/// 自定义NSEdgeInsets
public func NSEdgeInsetsMake(_ top: CGFloat = 0, _ left: CGFloat = 0, _ bottom: CGFloat = 0, _ right: CGFloat = 0) -> NSEdgeInsets{
    return NSEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

/// 自定义CGRect
public func CGRectMake(_ x: CGFloat = 0, _ y: CGFloat = 0, _ w: CGFloat = 0, _ h: CGFloat = 0) -> CGRect{
    return CGRect(x: x, y: y, width: w, height: h)
}

/// 自定义CGPointMake
public func CGPointMake(_ x: CGFloat = 0, _ y: CGFloat = 0) -> CGPoint {
    return CGPoint(x: x, y: y)
}

/// 自定义GGSizeMake
public func GGSizeMake(_ w: CGFloat = 0, _ h: CGFloat = 0) -> CGSize {
    return CGSize(width: w, height: h)
}

public func NSStringFromIndexPath(_ tableView: NSTableView, tableColumn: NSTableColumn, row: Int) -> String {
    let item: Int = tableView.tableColumns.firstIndex(of: tableColumn)!
    return String(format: "{%d, %d}", row, item);
}

///返回类名字符串
public func NNStringFromClass(_ cls: Swift.AnyClass) -> String {
    return String(describing: cls);// return "\(type(of: self))";
}

//获取本地创建类
public func NNClassFromString(_ name: String) -> AnyClass? {
    if let cls = NSClassFromString(name) {
//         print("✅_Objc类存在: \(name)")
        return cls;
     }
     
     let swiftClassName = "\(NSApplication.appBundleName).\(name)";
     if let cls = NSClassFromString(swiftClassName) {
//         print("✅_Swift类存在: \(swiftClassName)")
         return cls;
     }
     print("❌_类不存在: \(name)")
    return nil;
}

////获取本地创建类(Swift类,需要在名称之前加 . 符号,以示区别)
//public func NNClassFromString(_ name: String) -> AnyClass {
//    //    let nameKey = "CFBundleName";
//    //    这里也是坑，请不要翻译oc的代码，而是去NSBundle类里面看它的api
//    //    let appName = Bundle.main.infoDictionary!["CFBundleName"] as? String;
//    if name.contains(".") {
//        let className = "\(NSApplication.appBundleName).\(name.split(separator: ".").last!)"
//        return NSClassFromString(className)!;
//    }
//    let cls: AnyClass = NSClassFromString(name)!;
//    return cls;
//}

/// 获取本地 NSViewController 文件(Swift类,需要在名称之前加 . 符号,以示区别)
public func NSCtrFromString(_ vcName: String) -> NSViewController {
    let cls: AnyClass = NNClassFromString(vcName)!;
    // 通过类创建对象， 不能用cls.init(),有的类可能没有init方法
    // 需将cls转换为制定类型
    let vcCls = cls as! NSViewController.Type;
    // 创建对象
    let controller: NSViewController = vcCls.init();
    return controller;
}

/// 地址字符串(hostname + port)
public func UrlAddress(_ hostname: String, port: String) ->String {
    return NSString.UrlAddress(hostname, port: port);
}

///// 两个Int(+-*/)
//public func resultByOpt(_ num1: Int, _ num2: Int, result: (Int, Int) -> Int) -> Int {
//    return result(num1, num2);
//}

/// 两个数值(+-*/)
public func resultByOpt<T>(_ num1: T, _ num2: T, result: (T, T) -> T) -> T {
    return result(num1, num2);
}
