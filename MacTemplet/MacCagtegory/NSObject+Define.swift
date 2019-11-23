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
         print("✅_Objc类存在: \(name)")
        return cls;
     }
     
     let swiftClassName = "\(NSApplication.appBundleName).\(name)";
     if let cls = NSClassFromString(swiftClassName) {
         print("✅_Swift类存在: \(swiftClassName)")
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

//获取本地创建类(Swift类,需要在名称之前加 . 符号,以示区别)
public func SwiftClassFromString(_ name: String) -> AnyClass {
    let className = name.contains(".") == true ? name : ".\(name)"
    return NNClassFromString(className)!;
}

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

//public func NSNavCtrFromObj(_ obj: AnyObject) -> NSNavigationController?{
//    if obj is NSNavigationController {
//        return obj as? NSNavigationController;
//
//    } else if obj is String {
//        return NSNavigationController(rootViewController: NSCtrFromString(obj as! String));
//
//    } else if obj is NSViewController {
//        return NSNavigationController(rootViewController: obj as! NSViewController);
//
//    }
//    return nil;
//}
//
///// 获取NSViewController/NSNavigationController数组
//public func NSCtlrListFromList(_ list: [[String]], isNavController: Bool = false) -> [NSViewController] {
//    let tabItems: [NSTabBarItem] = NSTabBarItemsFromList(list);
//    let marr: NSMutableArray = [];
//    for e in list.enumerated() {
//        let itemList = e.element
//
//        let title: String = itemList.count > 1 ? itemList[1] : "";
//
//        var controller: NSViewController = NSCtrFromString(itemList.first!)
//        controller.title = title
//        controller.tabBarItem = tabItems[e.offset]
//
//        controller = isNavController == true ? NSNavCtrFromObj(controller)! : controller
//        marr.add(controller)
//    }
//    return marr.copy() as! [NSViewController]
//}

/// 获取NSNavigationController数组
//public func NSNavListFromList(_ list: [[String]]) -> [NSViewController] {
//    return NSCtlrListFromList(list, isNavController: true)
//}

/////获取NSTarBarController
//public func NSTarBarCtrFromList(_ list: [[String]]) -> NSTabBarController {
//    let tabBarVC: NSTabBarController = NSTabBarController()
//    tabBarVC.viewControllers = NSCtlrListFromList(list, isNavController: true)
//    return tabBarVC;
//}

/// 获取某种颜色Alpha下的色彩
public func NSColorAlpha(_ color: NSColor, _ a: CGFloat = 1.0) -> NSColor{
    return color.withAlphaComponent(a)
}

public func NSColorRGBA(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) -> NSColor{
    return NSColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

/// 16进制字符串
public func NSColorHex(_ hex: String, _ a: CGFloat = 1.0) -> NSColor {
    return NSColor.hex(hex, a: a);
}

/// [源]0x开头的16进制Int数字(无#前缀十六进制数表示，开头就是0x)
public func NSColorHexValue(_ hex: Int, _ a: CGFloat = 1.0) -> NSColor {
    return NSColor(red: CGFloat((hex & 0xFF0000) >> 16)/255.0, green: CGFloat((hex & 0xFF00) >> 8)/255.0, blue: CGFloat(hex & 0xFF)/255.0, alpha: a)
}
/// 随机颜色
public func NSColorRandom() -> NSColor {
    return NSColor.randomColor();
}

public func NSColorDim(_ white: CGFloat, _ a: CGFloat = 1.0) -> NSColor{
    return .init(white: white, alpha: a);
}
///// NSImage快捷方法
//public func NSImageNamed(_ name: String, renderingMode: NSImage.RenderingMode = .alwaysOriginal) -> NSImage?{
//    let image = NSImage(named: name)?.withRenderingMode(renderingMode)
//    return image
//}

//// 把颜色转成NSImage
//public func NSImageColor(_ color: NSColor, size: CGSize = CGSize(width: 1, height: 1)) -> NSImage{
//    let rect: CGRect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//    NSGraphicsBeginImageContextWithOptions(rect.size, false, 0)
//
//    let context: CGContext = NSGraphicsGetCurrentContext()!
//    context.setFillColor(color.cgColor)
//    context.fill(rect)
//
//    let image = NSGraphicsGetImageFromCurrentImageContext()
//    NSGraphicsGetCurrentContext()
//    return image!
//}
/// NSImage 相等判断
//public func NSImageEquelToImage(_ image0: NSImage, image1: NSImage) -> Bool{
//    let data0: Data = image0.pngData()!
//    let data1: Data = image1.pngData()!
//    return data0 == data1
//}
/// 地址字符串(hostname + port)
public func UrlAddress(_ hostname: String, port: String) ->String {
    var webUrl: String = hostname;
    if !hostname.contains("http://") {
        webUrl = "http://" + hostname;
    }
    if port != "" {
        webUrl = webUrl + ":\(port)";
    }
    return webUrl;
}

/// 富文本配置字典
public func AttributeDict(_ type: Int) -> [NSAttributedString.Key: Any]{
    var dic: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:  NSColor.theme,
                                              NSAttributedString.Key.backgroundColor:  NSColor.white,]
    
    switch type {
    case 1:
        dic[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue;
        dic[NSAttributedString.Key.underlineColor] = NSColor.theme;
        
    case 2:
        dic[NSAttributedString.Key.strikethroughStyle] = NSUnderlineStyle.single.rawValue;
        dic[NSAttributedString.Key.strikethroughColor] = NSColor.red;
        
    case 3:
        dic[NSAttributedString.Key.obliqueness] = 0.8;
        
    case 4:
        dic[NSAttributedString.Key.expansion] = 0.3;
        
    case 5:
        dic[NSAttributedString.Key.writingDirection] = 3;
        
    default:
        break
    }
    return dic;
}

/// data -> NSObject
public func ObjFromData(_ data: Data, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
    if JSONSerialization.isValidJSONObject(data) {
        return nil;
    }
    do {
        let obj: NSObject = try JSONSerialization.jsonObject(with: data, options: opt) as! NSObject
        return obj;
        
    } catch {
        print(error)
    }
    return nil;
}

/// string -> NSObject
public func ObjFromString(_ string: String, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
    let data: Data = string.data(using: .utf8)!
    let obj = ObjFromData(data)
    return obj;
}

/// NSObject -> string
public func JSONStringFromObj(_ obj: Any, options opt: JSONSerialization.WritingOptions = []) -> String? {
    let obj = try? JSONSerialization.data(withJSONObject: obj, options: opt);
    if let obj = obj {
        let string: String = (obj as NSData).jsonString()
        return string;
    }
    return nil;
}

///// 两个Int(+-*/)
//public func resultByOpt(_ num1: Int, _ num2: Int, result: (Int, Int) -> Int) -> Int {
//    return result(num1, num2);
//}

/// 两个数值(+-*/)
public func resultByOpt<T>(_ num1: T, _ num2: T, result: (T, T) -> T) -> T {
    return result(num1, num2);
}
