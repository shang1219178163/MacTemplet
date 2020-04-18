//
//  NSViewController+Hook.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSViewController+Hook.h"
#import "NSObject+Hook.h"
#import "NNView.h"

@implementation NSViewController (Hook)

+ (void)initialize{
    if (self == self.class) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            SwizzleMethodInstance(self.class, @selector(loadView), @selector(hook_loadView));
        });
    }
}

- (void)hook_loadView{
    NSWindow *window = NSApplication.sharedApplication.mainWindow;
    self.view = [[NNView alloc]initWithFrame:window.frame];
    self.view.wantsLayer = true;
}



@end
