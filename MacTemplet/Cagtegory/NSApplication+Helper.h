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

@end

NS_ASSUME_NONNULL_END
