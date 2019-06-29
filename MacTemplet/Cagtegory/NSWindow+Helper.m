//
//  NSWindow+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSWindow+Helper.h"

@implementation NSWindow (Helper)


+(NSWindow *)createWithRect:(CGRect)rect title:(NSString *)title{
    //窗口 关闭，缩小，放大等功能，根据需求自行组合
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    NSWindow * window = [[NSWindow alloc]initWithContentRect:rect styleMask:style backing:NSBackingStoreBuffered defer:false];
    if (title) {
        window.title = title;
    }
    return window;
}

+(NSWindow *)createWithSize:(CGSize)size title:(NSString *)title{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    NSWindow * window = [NSWindow createWithRect:rect title:title];
    return window;
}

+(NSWindow *)createMainWindowTitle:(NSString *)title{
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

+(NSWindow *)createWithCtrlName:(NSString *)ctrlName size:(CGSize)size{
    NSViewController * controller = [[NSClassFromString(ctrlName) alloc] init];
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        controller.view.frame = CGRectMake(0, 0, size.width, size.height);
    }
    
    NSWindow * window = [NSWindow createWithSize:size title:controller.title];
    window.contentViewController = controller;
    return window;
}

//+(NSWindow *)createWithTitle:(NSString *)title{
//    //窗口 关闭，缩小，放大等功能，根据需求自行组合
//    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
//    CGFloat screenWidth = NSScreen.mainScreen.frame.size.width;
//    CGFloat screenHeight = NSScreen.mainScreen.frame.size.height;
//
//    NSWindow * window = [[NSWindow alloc]initWithContentRect:CGRectMake(0, 0, screenWidth*0.4, screenHeight*0.5) styleMask:style backing:NSBackingStoreBuffered defer:true];
//    window.title = title;
//    window.contentMinSize = window.frame.size;
//    [window makeKeyAndOrderFront:self]; //设置 NSApplication.sharedApplication.mainWindow
//    [window center];
//    return window;
//}
//
//+(NSWindow *)createWithSize:(CGSize)size title:(NSString *)title{
//    //窗口 关闭，缩小，放大等功能，根据需求自行组合
//    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
//    NSWindow * window = [[NSWindow alloc]initWithContentRect:CGRectMake(0, 0, size.width, size.height) styleMask:style backing:NSBackingStoreBuffered defer:false];
//    window.title = title;
//    return window;
//}
//
//+(NSWindow *)createWithCtrlName:(NSString *)ctrlName size:(CGSize)size{
//
//    NSViewController * controller = [[NSClassFromString(ctrlName) alloc] init];
//    if (!CGSizeEqualToSize(CGSizeZero, size)) {
//        controller.view.frame = CGRectMake(0, 0, size.width, size.height);
//    }
//
//    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable | NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
//    NSWindow * window = [[NSWindow alloc]initWithContentRect:CGRectMake(0, 0, size.width, size.height) styleMask:style backing:NSBackingStoreBuffered defer:false];
//
//    window.contentViewController = controller;
//    if (controller.title) {
//        window.title = controller.title;
//    }
//    return window;
//}

@end
