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

- (void)addActionHandler:(void(^)(NSControl *control))handler forControlEvents:(NSEventMask)controlEvents{    
    self.action = @selector(p_handleActionBtn:);
    self.target = self;
    [self sendActionOn:controlEvents];
    
    objc_setAssociatedObject(self, _cmd, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)p_handleActionBtn:(NSControl *)sender{
    void(^block)(NSControl *control) = objc_getAssociatedObject(self, @selector(addActionHandler:forControlEvents:));
    if (block) block(sender);
    
}


@end
