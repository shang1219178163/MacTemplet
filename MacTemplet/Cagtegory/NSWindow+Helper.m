//
//  NSWindow+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSWindow+Helper.h"

@implementation NSWindow (Helper)


+(instancetype)createWithRect:(CGRect)rect title:(NSString *)title{
    //窗口 关闭，缩小，放大等功能，根据需求自行组合
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    NSWindow * window = [[NSWindow alloc]initWithContentRect:rect styleMask:style backing:NSBackingStoreBuffered defer:false];
    if (title) {
        window.title = title;
    }
    return window;
}

+(instancetype)createWithSize:(CGSize)size title:(NSString *)title{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    NSWindow * window = [NSWindow createWithRect:rect title:title];
    return window;
}

+(instancetype)createMainWindowTitle:(NSString *)title{
    //窗口 关闭，缩小，放大等功能，根据需求自行组合
    CGFloat screenWidth = NSScreen.mainScreen.frame.size.width;
    CGFloat screenHeight = NSScreen.mainScreen.frame.size.height;
    
    CGRect rect = CGRectMake(0, 0, screenWidth*0.4, screenHeight*0.5);
    NSWindow * window = [NSWindow createWithRect:rect title:title];
    window.contentMinSize = window.frame.size;
    [window makeKeyAndOrderFront:self];
    [window center];
    return window;
}

+(instancetype)createWithCtrlName:(NSString *)ctrlName size:(CGSize)size{
    NSViewController * controller = [[NSClassFromString(ctrlName) alloc] init];
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        controller.view.frame = CGRectMake(0, 0, size.width, size.height);
    }
    
    NSWindow * window = [NSWindow createWithSize:size title:controller.title];
    window.contentViewController = controller;
    return window;
}

@end
