//
//  NSTableView+Hook.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTableView+Hook.h"
#import <objc/runtime.h>

@implementation NSTableView (Hook)

//+ (void)initialize{
//    if (self == self.class) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            [self swizzleMethodInstance:self.class origSel:@selector(init) replSel:@selector(hook_init)];
//
//        });
//    }
//}


//- (void)hook_init{
//    [self hook_init];
//
//    NSScrollView *scrollView = [NSView createScrollViewRect:CGRectZero];
//    scrollView.documentView = self;
//    DDLog(@"%@_%@_%@",self, scrollView.documentView, scrollView);
//
//}

#pragma mark -lazy
//-(NSScrollView *)scrollView{
//    id obj = objc_getAssociatedObject(self, _cmd);
//    if (!obj) {
//        NSScrollView *obj = [NSView createScrollViewRect:CGRectZero];
//        objc_setAssociatedObject(self, _cmd, obj, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return obj;
//}
//
//- (void)setScrollView:(NSScrollView *)scrollView{
//    objc_setAssociatedObject(self, @selector(scrollView), scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

@end
