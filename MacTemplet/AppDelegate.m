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
    NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
//    self.window.contentViewController = controller;
    NSApplication.windowDefault.contentViewController = controller;
    NSApplication.windowDefault.title = NSApplication.appName;
//    DDLog(@"%@",NSApplication.sharedApplication.mainWindow);
//    DDLog(@"%@",NSApp.mainWindow);
//    DDLog(@"%@",NSApplication.windowDefault);

}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
