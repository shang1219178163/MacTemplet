//
//  NSView+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSView+Helper.h"

@implementation NSView (Helper)

/**
 给所有自视图加框
 */
- (void)getViewLayer{
    NSArray *subviews = self.subviews;
    if (subviews.count == 0) return;
    for (NSView *subview in subviews) {
        subview.wantsLayer = true;
        subview.layer.borderWidth = 1.5;
        subview.layer.borderColor = NSColor.blueColor.CGColor;
//        subview.layer.borderColor = UIColor.clearColor.CGColor;
        
        [subview getViewLayer];
        
    }
}

@end
