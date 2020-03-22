
//
//  NSView+Ext.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/21.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NSView+Ext.h"

#import <AppKit/AppKit.h>


@implementation NSView (Ext)

- (void)drawLineDashRect:(NSRect)rect {
    //将按钮边框绘制成虚线
    self.wantsLayer = true;
//    [self setBordered:NO];
    self.layer.backgroundColor = NSColor.whiteColor.CGColor;

    NSBezierPath *path = [NSBezierPath bezierPathWithRect:self.layer.frame];
    CGFloat dash_pattern[] = {15.0, 10.0, 3.0, 10.0};//{线段1长度，线段1间距，线段2长度，线段2间距, ......}
    NSInteger count = sizeof(dash_pattern)/sizeof(dash_pattern[0]);
    [path setLineWidth:3.0f];
    [path setLineCapStyle:NSSquareLineCapStyle];
    [path setLineDash:dash_pattern count:count phase:0.0];
    [[NSColor redColor] set];
    [path stroke];
}

@end
