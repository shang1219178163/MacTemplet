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

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SwizzleMethodInstance(self.class, @selector(init), @selector(init_hook));
        SwizzleMethodInstance(self.class, @selector(initWithFrame:), @selector(initWithFrame_hook:));
        SwizzleMethodInstance(self.class, @selector(initWithCoder:), @selector(initWithCoder_hook:));
        
    });
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
