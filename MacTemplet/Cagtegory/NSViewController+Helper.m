

//
//  NSViewController+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSViewController+Helper.h"
#import <objc/runtime.h>

//FOUNDATION_EXPORT Class _Nullable NSClassFromString(NSString *aClassName);
NSViewController * NSCtrlFromString(NSString *aControllerName){
    return [[NSClassFromString(aControllerName) alloc] init];
}


@implementation NSViewController (Helper)

- (NSWindow *)currentWindow{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setCurrentWindow:(NSWindow *)currentWindow{
    objc_setAssociatedObject(self, @selector(currentWindow), currentWindow, OBJC_ASSOCIATION_RETAIN);
}


@end
