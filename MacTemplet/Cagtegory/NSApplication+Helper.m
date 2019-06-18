//
//  NSApplication+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSApplication+Helper.h"
#import <objc/runtime.h>


@implementation NSApplication (Helper)

static NSWindow *_windowDefault = nil;

+(NSWindow *)windowDefault{
    if (!_windowDefault) {
        _windowDefault = [NSWindow createWithTitle:@"Main Window"];
//        _windowDefault = ({
//            //窗口 关闭，缩小，放大等功能，根据需求自行组合
//            NSUInteger style = NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
//            CGFloat screenWidth = NSScreen.mainScreen.frame.size.width;
//            CGFloat screenHeight = NSScreen.mainScreen.frame.size.height;
//
//            NSWindow * window = [[NSWindow alloc]initWithContentRect:CGRectMake(0, 0, screenWidth*0.4, screenHeight*0.4) styleMask:style backing:NSBackingStoreBuffered defer:true];
//            window.contentMinSize = window.frame.size;
//            window.title = @"Main Window";
//            [window makeKeyAndOrderFront:self]; //设置 NSApplication.sharedApplication.mainWindow
//            [window center];
//            window;
//        });
    }
    return _windowDefault;
}

+ (void)setWindowDefault:(NSWindow *)windowDefault{
    _windowDefault = windowDefault;
}

+(NSString *)appName{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return  infoDict[@"CFBundleDisplayName"] ? : infoDict[@"CFBundleName"];
}

+(NSImage *)appIcon{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    NSString *icon = infoDict[@"CFBundleIconName"];
    NSImage * image = [NSImage imageNamed:icon];
    return image;
}

+(NSString *)appVer{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return infoDict[@"CFBundleShortVersionString"];
}

+(NSString *)appBuild{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return infoDict[@"CFBundleVersion"];
}

+(NSString *)platforms{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return infoDict[@"CFBundleSupportedPlatforms"];
}

+(NSString *)systemInfo{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return infoDict[@"DTSDKName"];
}

+(NSString *)appCopyright{
    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
    return infoDict[@"NSHumanReadableCopyright"];
}

@end
