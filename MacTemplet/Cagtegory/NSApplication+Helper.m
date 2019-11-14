//
//  NSApplication+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSApplication+Helper.h"
#import <objc/runtime.h>
#import "NSDateFormatter+Helper.h"

@implementation NSApplication (Helper)

static NSWindow *_windowDefault = nil;
+(NSWindow *)windowDefault{
    if (!_windowDefault) {
        _windowDefault = [NSWindow createMainWindowTitle:@"MainWindow"];
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

static NSDictionary *_infoDic = nil;
+ (NSDictionary *)infoDic{
    if(!_infoDic){
        _infoDic = NSBundle.mainBundle.infoDictionary;
    }
    return _infoDic;
}

+(NSString *)appName{
    return self.infoDic[@"CFBundleDisplayName"] ? : self.infoDic[@"CFBundleName"];
}

+(NSString *)appBundleName{
    return self.infoDic[@"CFBundleExecutable"];
}

+(NSImage *)appIcon{
    NSString *icon = self.infoDic[@"CFBundleIconName"];
    NSImage * image = [NSImage imageNamed:icon];
    return image;
}

+(NSString *)appVer{
    return self.infoDic[@"CFBundleShortVersionString"];
}

+(NSString *)appBuild{
    return self.infoDic[@"CFBundleVersion"];
}

+(NSString *)platforms{
    return self.infoDic[@"CFBundleSupportedPlatforms"];
}

+(NSString *)systemInfo{
    return self.infoDic[@"DTSDKName"];
}

+(NSString *)appCopyright{
    return self.infoDic[@"NSHumanReadableCopyright"];
}

+(NSString *)macUserName{
    return NSProcessInfo.processInfo.userName;
}

+(NSString *)macLocalizedName{
    return NSHost.currentHost.localizedName;
}

static NSDictionary * _macSystemDic = nil;
+(NSDictionary *)macSystemDic{
    if (!_macSystemDic) {
        _macSystemDic = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
    }
    return _macSystemDic;
}

+(NSString *)macProductName{
    return self.macSystemDic[@"ProductName"] ? : @"";
}

+(NSString *)macCoryright{
    return self.macSystemDic[@"ProductCopyright"] ? : @"";
}

+(NSString *)macSystemVers{
    return self.macSystemDic[@"ProductVersion"] ? : @"";
}

+(NSString *)classCopyright{
    NSString *dateStr = [NSDateFormatter stringFromDate:NSDate.date format:@"yyyy/MM/dd"];
    NSString *year = [dateStr componentsSeparatedByString:@"/"].firstObject;
    NSString *result = [NSString stringWithFormat:@"//\n\
//\n\
//  MacTemplet\n\
//\n\
//  Created by %@ on %@.\n\
//  Copyright © %@ %@. All rights reserved.\n\
//\n\n", self.macUserName, dateStr, year, self.macUserName];
    return result;
}

@end
