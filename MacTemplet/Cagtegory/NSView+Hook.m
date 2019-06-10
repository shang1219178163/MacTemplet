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

//+ (void)initialize{
//    if (self == self.class) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            Ivar nameIvar = class_getInstanceVariable(self.class, "_wantsLayer");
//            object_setIvar(self.class, nameIvar, @(true));
//            NSLog(@"%@", object_getIvar(self.class, nameIvar));
//                  
//            [self swizzleMethodInstance:self.class origSel:@selector(init:) replSel:@selector(hook_init:)];
//            [self swizzleMethodInstance:self.class origSel:@selector(initWithFrame:) replSel:@selector(hook_initWithFrame:)];
//
////            SwizzleMethodInstance(@"NSView", @selector(init), @selector(hook_init));
//            
//        });
//    }
//}



//
//- (void)hook_setWantsLayer:(BOOL)wantsLayer{
//
//}

// 我们自己实现的方法，也就是和self的viewDidLoad方法进行交换的方法。
//- (instancetype)hook_init{
//  
//    [self hook_init];
//    
//}


@end
