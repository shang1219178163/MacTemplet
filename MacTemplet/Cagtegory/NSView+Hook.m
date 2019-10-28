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
            
            [self swizzleMethodInstance:self.class origSel:@selector(init) replSel:@selector(init_hook)];
            [self swizzleMethodInstance:self.class origSel:@selector(initWithFrame:) replSel:@selector(initWithFrame_hook:)];
            [self swizzleMethodInstance:self.class origSel:@selector(initWithCoder:) replSel:@selector(initWithCoder_hook:)];
            
        });
    }
}

- (id)init_hook{
    self = [self init_hook];
    if (self) {
        self.wantsLayer = true;
    }
    return self;
}

- (id)initWithFrame_hook:(NSRect)frameRect{
    self = [self initWithFrame_hook:frameRect];
    if (self) {
        if (![self respondsToSelector:@selector(initWithScrollView:orientation:)]) {
            self.wantsLayer = true;
        }
    }
    return self;
}

- (id)initWithCoder_hook:(NSCoder *)decoder{
    self = [self initWithCoder_hook:decoder];
    if (self) {
        self.wantsLayer = true;
    }
    return self;
}


@end
