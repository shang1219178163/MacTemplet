//
//  AppDelegate.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints"];
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"LAYOUT_CONSTRAINTS_NOT_SATISFIABLE"];

    
    NSString * controllerName = @"HomeViewController";
//    controllerName = @"FirstViewController";
//    controllerName = @"MainViewController";
//    controllerName = @"GroupViewController";
    
    NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
    
    NSApplication.windowDefault.contentViewController = controller;
    NSApplication.windowDefault.title = NSApplication.appName;
//    DDLog(@"%@",NSApplication.sharedApplication.mainWindow);
//    DDLog(@"%@",NSApp.mainWindow);
//    DDLog(@"%@",NSApplication.windowDefault);
    [NSUserDefaults.standardUserDefaults setObject:@(0) forKey: @"NSInitialToolTipDelay"];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}
/// 点击dock图标重新弹出窗口方法
- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
    NSLog(@"hasVisibleWindows:%d",flag);
    [NSApp activateIgnoringOtherApps:false];//取消其他程序的响应
    [NSApp.mainWindow makeKeyAndOrderFront:self];//主窗口显示自己方法一
    return YES;
}


@end
