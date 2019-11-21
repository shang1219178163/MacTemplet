//
//  NSView+Add.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/10/28.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSView+Add.h"

#import <AppKit/AppKit.h>
#import <objc/runtime.h>

@implementation NSView (Add)

- (CGPoint)center{
    return CGPointMake(self.frame.origin.x + self.frame.size.width*0.5,
                       self.frame.origin.y + self.frame.size.height*0.5);
}

- (void)setCenter:(CGPoint)center{
    self.frame = CGRectMake(center.x - self.frame.size.width*0.5,
                            center.y - self.frame.size.height*0.5,
                            self.frame.size.width,
                            self.frame.size.height);
}

-(NSView *)lineTop{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
            CGRect rect = CGRectMake(0, 0, CGRectGetWidth(self.bounds), kH_LINE_VIEW);
            NSView *view = [[NSView alloc] initWithFrame:rect];
            view.layer.backgroundColor = NSColor.lineColor.CGColor;
            
            view;
        });
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (void)setLineTop:(NSView *)lineTop{
    objc_setAssociatedObject(self, @selector(lineTop), lineTop, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSView *)lineBottom{
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        obj = ({
            CGRect rect = CGRectMake(0, CGRectGetHeight(self.bounds) - kH_LINE_VIEW, CGRectGetWidth(self.bounds), kH_LINE_VIEW);
            NSView *view = [[NSView alloc] initWithFrame:rect];
            view.layer.backgroundColor = NSColor.lineColor.CGColor;

            view;
        });
        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return obj;
}

- (void)setLineBottom:(NSView *)lineBottom{
    objc_setAssociatedObject(self, @selector(lineBottom), lineBottom, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
