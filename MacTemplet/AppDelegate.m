//
//  AppDelegate.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate.h"
#import "NSApplication+Helper.h"

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

    NSLog(@"%@_%@",NSStringFromSelector(_cmd), NSApplication.sharedApplication.mainWindow);
    NSLog(@"%@_%@",NSStringFromSelector(_cmd), NSApp.mainWindow);
    NSLog(@"%@_%@",NSStringFromSelector(_cmd), NSApplication.windowDefault);

}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
