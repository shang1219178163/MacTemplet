//
//  NSApplication+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSApplication (Helper)

/// 自定义mainWindow
@property (class, nonatomic) NSWindow *windowDefault;

@property (class, readonly) NSDictionary *infoDic;
@property (class, readonly) NSString *appName;
@property (class, readonly) NSString *appBundleName;
@property (class, readonly, nullable) NSImage *appIcon;
@property (class, readonly) NSString *appVer;
@property (class, readonly, nullable) NSString *appBuild;
@property (class, readonly, nullable) NSString *platforms;
@property (class, readonly, nullable) NSString *systemInfo;
@property (class, readonly, nullable) NSString *appCopyright;
@property (class, readonly, nullable) NSString *macUserName;
@property (class, readonly, nullable) NSString *macLocalizedName;

@property (class, readonly) NSDictionary *macSystemDic;
@property (class, readonly) NSString *macProductName;
@property (class, readonly) NSString *macCoryright;
@property (class, readonly) NSString *macSystemVers;
/// 类文件顶部信息
@property (class, readonly) NSString *classCopyright;

@end

NS_ASSUME_NONNULL_END
