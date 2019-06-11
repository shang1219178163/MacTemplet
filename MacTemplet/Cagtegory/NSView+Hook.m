//
//  NSView+Hook.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSView+Hook.h"
#import "NSObject+Hook.h"

@implementation NSView (Hook)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            [self swizzleMethodInstance:self.class origSel:@selector(viewDidMoveToSuperview) replSel:@selector(hook_viewDidMoveToSuperview)];

        });
    }
}

- (void)hook_viewDidMoveToSuperview{
    self.wantsLayer = true;
    [self hook_viewDidMoveToSuperview];
    
}


@end
