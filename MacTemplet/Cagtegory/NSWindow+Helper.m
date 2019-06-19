//
//  NSWindow+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSWindow+Helper.h"

@implementation NSWindow (Helper)

+(NSWindow *)createWithTitle:(NSString *)title{
    //窗口 关闭，缩小，放大等功能，根据需求自行组合
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    CGFloat screenWidth = NSScreen.mainScreen.frame.size.width;
    CGFloat screenHeight = NSScreen.mainScreen.frame.size.height;
    
    NSWindow * window = [[NSWindow alloc]initWithContentRect:CGRectMake(0, 0, screenWidth*0.4, screenHeight*0.4) styleMask:style backing:NSBackingStoreBuffered defer:true];
    window.contentMinSize = window.frame.size;
    window.title = title;
    [window makeKeyAndOrderFront:self]; //设置 NSApplication.sharedApplication.mainWindow
    [window center];
    
    return window;
}

+(NSWindow *)createWithSize:(CGSize)size title:(NSString *)title{
    //窗口 关闭，缩小，放大等功能，根据需求自行组合
    NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    NSWindow * window = [[NSWindow alloc]initWithContentRect:CGRectMake(0, 0, size.width, size.height) styleMask:style backing:NSBackingStoreBuffered defer:false];
    window.title = title;
    
    return window;
}

@end
