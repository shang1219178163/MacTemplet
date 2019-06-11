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
@property (class, nonatomic, nonnull) NSWindow *windowDefault;

@property (class, readonly, nullable) NSString *appName;
@property (class, readonly, nullable) NSImage *appIcon;
@property (class, readonly, nullable) NSString *appVer;
@property (class, readonly, nullable) NSString *appBuild;

@end

NS_ASSUME_NONNULL_END
