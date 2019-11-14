//
//  NSControl+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSControl+Helper.h"
#import <objc/runtime.h>

@implementation NSControl (Helper)

- (void)addActionHandler:(void(^)(NSControl *control))handler{
    self.action = @selector(p_handleActionBtn:);
    self.target = self;
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionBtn:(NSControl *)sender{
    void(^block)(NSControl *control) = objc_getAssociatedObject(self, @selector(addActionHandler:));
    if (block) block(sender);
}

- (void)addActionHandler:(void(^)(NSControl *control))handler forTrackingMode:(NSSegmentSwitchTracking)trackingMode{
    assert([self isKindOfClass:NSSegmentedControl.class]);
    self.action = @selector(p_handleActionSegmentCtl:);
    self.target = self;
    ((NSSegmentedControl *)self).trackingMode = trackingMode;
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionSegmentCtl:(NSControl *)sender{
    void(^block)(NSControl *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forTrackingMode:));
    if (block) block(sender);

}

//- (void)addActionHandler:(void(^)(NSControl *control))handler forControlEvents:(NSEventMask)controlEvents{
//    self.action = @selector(p_handleActionBtn:);
//    self.target = self;
//    [self sendActionOn:controlEvents];
//
//    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}
//
//- (void)p_handleActionBtn:(NSControl *)sender{
//    void(^block)(NSControl *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
//    if (block) block(sender);
//
//}

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(NSEventMask)controlEvents{
    self.target = target;
    self.action = action;
    [self sendActionOn:controlEvents];
}

@end
