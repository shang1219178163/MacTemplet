//
//  AppDelegate.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

//@property (weak) IBOutlet NSWindow *window;
@property (nonatomic, strong) NSWindow *window;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints"];
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"LAYOUT_CONSTRAINTS_NOT_SATISFIABLE"];

    
    //窗口 关闭，缩小，放大等功能，根据需求自行组合
    NSUInteger style =  NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |NSWindowStyleMaskMiniaturizable | NSWindowStyleMaskResizable;
    self.window = [[NSWindow alloc]initWithContentRect:CGRectMake(0, 0, kScreenWidth*0.5, kScreenHeight*0.5) styleMask:style backing:NSBackingStoreBuffered defer:YES];
    self.window.contentMinSize = self.window.frame.size;
    self.window.title = @"Hellow window";
    [self.window makeKeyAndOrderFront:self];
    [self.window center];
    
    
    NSLog(@"self.window:%@",self.window);

    
    NSViewController * controller = [[NSClassFromString(@"HomeViewController") alloc] init];
    self.window.contentViewController = controller;
    
}


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}


@end
