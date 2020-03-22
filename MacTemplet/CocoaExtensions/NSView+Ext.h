//
//  NSView+Ext.h
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/21.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Ext)

/// 绘制边框曲线
- (void)drawLineDashRect:(NSRect)rect;

@end

NS_ASSUME_NONNULL_END
