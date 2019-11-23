//
//  NSApplication+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSApplication{
    
    static var windowDefault: NSWindow {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeySelector(#function)) as? NSWindow
            if obj == nil {
                obj = NSWindow.create(title: "MainWindow");
                objc_setAssociatedObject(self, RuntimeKeySelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeySelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    static var appName: String {
        let infoDic = Bundle.main.infoDictionary;
        let name = infoDic!["CFBundleDisplayName"] ?? infoDic![kCFBundleNameKey as String]
        return name as! String;
    }
    
    static var appBundleName: String {
        let infoDic = Bundle.main.infoDictionary;
        return infoDic!["CFBundleExecutable"] as! String;
    }
    
    static var appIcon: NSImage {
        let infoDic = Bundle.main.infoDictionary;
        let imgName = infoDic!["CFBundleIconName"]
        return NSImage(named: imgName as! NSImage.Name)!
    }
    
    static var appVer: String {
        let infoDic = Bundle.main.infoDictionary;
        return infoDic!["CFBundleShortVersionString"] as! String;
    }
    
    static var appBuild: String {
        let infoDic = Bundle.main.infoDictionary;
        return infoDic!["CFBundleVersion"] as! String;
    }
    
    static var systemInfo: String {
        return Bundle.main.infoDictionary!["DTSDKName"] as! String;
    }
    
    static var appCopyright: String {
        return Bundle.main.infoDictionary!["NSHumanReadableCopyright"] as! String;
    }
    
    static var macUserName: String {
        return ProcessInfo.processInfo.userName;
    }
    
    static var macLocalizedName: String {
        return Host.current().localizedName ?? "";
    }
    
    static var macSystemDic: NSDictionary? {
        return NSDictionary(contentsOfFile: "/System/Library/CoreServices/SystemVersion.plist")
    }
    
    static var macProductName: String {
        return (self.macSystemDic?["ProductName"] as! String);
    }
    
    static var macCoryright: String {
        return (self.macSystemDic?["ProductCopyright"] as! String);
    }
    
    static var macSystemVers: String {
        return (self.macSystemDic?["ProductVersion"] as! String);
    }
    
    static var classCopyright: String {
        let dateStr = DateFormatter.stringFromDate(Date(), fmt: "yyyy/MM/dd HH:mm")
        let year = dateStr.components(separatedBy: "/").first!
        let result = """
        //\n\
        //\n\
        //  MacTemplet\n\
        //\n\
        //  Created by \(self.macUserName) on \(dateStr).\n\
        //  Copyright © \(year) \(self.macUserName). All rights reserved.\n\
        //\n\n
        """
        return result;
    }
    
//    ///默认风格是白色导航栏黑色标题
//    static func setupAppearanceDefault(_ isDefault: Bool = true) {
//        let barTintColor: UIColor = isDefault ? UIColor.white : UIColor.theme
//        setupAppearanceNavigationBar(barTintColor)
//        setupAppearanceScrollView()
//        setupAppearanceOthers();
//    }
//
//    /// 配置UIScrollView默认值
//    static func setupAppearanceScrollView() {
//        UITableView.appearance().separatorStyle = .singleLine;
//        UITableView.appearance().separatorInset = .zero;
//        UITableView.appearance().rowHeight = 60;
//
//        UITableViewCell.appearance().layoutMargins = .zero;
//        UITableViewCell.appearance().separatorInset = .zero;
//        UITableViewCell.appearance().selectionStyle = .none;
//
//        UIScrollView.appearance().keyboardDismissMode = .onDrag;
//
//        if #available(iOS 11.0, *) {
//            UITableView.appearance().estimatedRowHeight = 0.0;
//            UITableView.appearance().estimatedSectionHeaderHeight = 0.0;
//            UITableView.appearance().estimatedSectionFooterHeight = 0.0;
//
//            UICollectionView.appearance().contentInsetAdjustmentBehavior = .never;
//            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never;
//        }
//    }
//
//    static func setupAppearanceOthers() {
//        UIButton.appearance().isExclusiveTouch = false;
//
//        UITabBar.appearance().tintColor = UIColor.theme;
//        UITabBar.appearance().barTintColor = UIColor.white;
//        UITabBar.appearance().isTranslucent = false;
//
//        if #available(iOS 10.0, *) {
//            UITabBar.appearance().unselectedItemTintColor = UIColor.gray;
//        }
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5.0)
//
//    }
//
//    /// 配置UINavigationBar默认值
//    static func setupAppearanceNavigationBar(_ barTintColor: UIColor) {
//        let isDefault: Bool = UIColor.white.equalTo(barTintColor);
//        let tintColor = isDefault ? UIColor.black : UIColor.white;
//
//        UINavigationBar.appearance().tintColor = tintColor;
//        UINavigationBar.appearance().barTintColor = barTintColor;
//        UINavigationBar.appearance().setBackgroundImage(UIImageColor(barTintColor), for: UIBarPosition.any, barMetrics: .default)
//        UINavigationBar.appearance().shadowImage = UIImageColor(barTintColor);
//
//        let attDic = [NSAttributedString.Key.foregroundColor :   tintColor,
////                      NSAttributedString.Key.font    :   UIFont.boldSystemFont(ofSize:18)
//                    ];
//        UINavigationBar.appearance().titleTextAttributes = attDic;
////
////        let dicNomal = [NSAttributedString.Key.foregroundColor: UIColor.white,
////        ]
////        UIBarButtonItem.appearance().setTitleTextAttributes(dicNomal, for: .normal)
//    }
//
//    static func setupAppearanceTabBar() {
//        //         设置字体颜色
////        let attDic_N = [NSAttributedString.Key.foregroundColor: UIColor.black];
////        let attDic_H = [NSAttributedString.Key.foregroundColor: UIColor.theme];
////        UITabBarItem.appearance().setTitleTextAttributes(attDic_N, for: .normal);
////        UITabBarItem.appearance().setTitleTextAttributes(attDic_H, for: .selected);
////        // 设置字体偏移
////        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5.0);
//        // 设置图标选中时颜色
////        UITabBar.appearance().tintColor = .red;
//    }
//
//    @available(iOS 9.0, *)
//    static func setupAppearanceSearchbarCancellButton(_ textColor: UIColor = .theme) {
//        let shandow: NSShadow = {
//            let shadow = NSShadow();
//            shadow.shadowColor = UIColor.darkGray;
//            shadow.shadowOffset = CGSize(width: 0, height: -1);
//            return shadow;
//        }();
//
//        let dic: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:  textColor,
//                                                  NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 13),
//                                                  NSAttributedString.Key.shadow:  shandow,
//        ]
//        UIBarButtonItem.appearance().setTitleTextAttributes(dic, for: .normal)
//        UIBarButtonItem.appearance().setTitleTextAttributes(dic, for: .highlighted)
//        UIBarButtonItem.appearance().setTitleTextAttributes(dic, for: .selected)
//
//        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
//    }
    
    /// http/https请求链接
    func isNormalURL(_ url: NSURL) -> Bool {
        guard let scheme = url.scheme else {
            fatalError("url.scheme不能为nil")
        }
        
        let schemes = ["http", "https"]
        return schemes.contains(scheme)
    }
    
    /// 打开网络链接
    static func openURL(_ urlStr: String, isUrl: Bool = true) {
        if isUrl == true {
            _ = NSApplication.openURLStr(urlStr, prefix: "http://")
        } else {
            _ = NSApplication.openURLStr(urlStr, prefix: "tel://")
        }
    }
    
    /// 打开网络链接(prefix为 http://或 tel:// )
    static func openURLStr(_ urlStr: String, prefix: String = "http://") {
//        let set = NSCharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]").inverted;
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: set)!;
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!;
        var tmp = urlStr;
        if urlStr.hasPrefix(prefix) == false {
            tmp = prefix + urlStr;
        }
        NSWorkspace.shared.open(URL(string: tmp)!)
    }

    /// 远程推送deviceToken处理
    static func deviceTokenString(_ deviceToken: NSData) -> String{
        var deviceTokenString = String()
        if #available(iOS 13.0, *) {
            let bytes = [UInt8](deviceToken)
            for item in bytes {
                deviceTokenString += String(format:"%02x", item&0x000000FF)
            }
            
        } else {
            deviceTokenString = deviceToken.description.trimmingCharacters(in: CharacterSet(charactersIn: "<> "))
        }
#if DEBUG
        print("deviceToken：\(deviceTokenString)");
#endif
        return deviceTokenString;
    }

    /// 配置app图标(传 nil 恢复默认)
    static func setAppIcon(name: String?) {
        if name == nil {
            // 恢复默认图片
            return;
        }
        NSApplication.shared.applicationIconImage = NSImage(named: name!)
    }
}
