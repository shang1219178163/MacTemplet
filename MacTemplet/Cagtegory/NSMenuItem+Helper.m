
//
//  NSMenuItem+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSMenuItem+Helper.h"
#import <objc/runtime.h>

@implementation NSMenuItem (Helper)

- (void)addActionHandler:(void(^)(NSMenuItem *menuItem))handler{
    self.target = self;
    self.action = @selector(p_handleAction:);

    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleAction:(NSMenuItem *)menuItem{
    void(^block)(NSMenuItem *menuItem) = objc_getAssociatedObject(self, @selector(addActionHandler:));
    if (block) block(menuItem);
}

- (NSMenuItem *)initWithTitle:(NSString *)string keyEquivalent:(NSString *)charCode handler:(void(^)(NSMenuItem *menuItem))handler{
    NSMenuItem * item = [[NSMenuItem alloc]initWithTitle:string action:nil keyEquivalent:charCode];
    [item addActionHandler:handler];
    return item;
}

@end
