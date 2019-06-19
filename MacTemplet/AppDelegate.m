//
//  AppDelegate.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate.h"
#import "MainWindowController.h"
#import "FirstViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) MainWindowController *windowCtrl;

@property(nonatomic,strong) NSPopover *firstPopover;
@property(nonatomic,strong) FirstViewController * firstVC;

@end

@implementation AppDelegate

//- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
//    // Insert code here to initialize your application
//
//    NSString * controllerName = @"HomeViewController";
////    controllerName = @"FirstViewController";
//    controllerName = @"MainViewController";
////    controllerName = @"GroupViewController";
//
//    NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
//    self.windowCtrl.window.contentViewController = controller;
//    self.windowCtrl.window.title = NSApplication.appName;
//
//    [self addStatusItemRight];
//}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints"];
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"LAYOUT_CONSTRAINTS_NOT_SATISFIABLE"];

    NSString * controllerName = @"HomeViewController";
//    controllerName = @"FirstViewController";
    controllerName = @"MainViewController";
    controllerName = @"GroupViewController";
//    controllerName = @"CollectionViewController";

    NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
    NSApplication.windowDefault.contentViewController = controller;
    NSApplication.windowDefault.title = NSApplication.appName;

//    DDLog(@"%@",NSApplication.sharedApplication.mainWindow);
//    DDLog(@"%@",NSApp.mainWindow);
//    DDLog(@"%@",NSApplication.windowDefault);
    [NSUserDefaults.standardUserDefaults setObject:@(0) forKey: @"NSInitialToolTipDelay"];
    [self addStatusItemRight];

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

#pragma mark -funtions

#pragma mark -addStatusItemRight

- (void)addStatusItemRight{
    self.statusItem = [NSStatusItem createStatusItemImageName:nil];
    self.statusItem.menu = ({
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"menu_right"];
        [menu addItemWithTitle:@"Load1"action:@selector(menuItemAction0) keyEquivalent:@"E"];
        [menu addItemWithTitle:@"退出"  action:@selector(menuItemQuit) keyEquivalent:@""];

        menu;
    });
    
    self.statusItem.button.target = self;
    self.statusItem.button.action = @selector(hanldeStatusBtnClick:);
    
//    self.statusItem.view = ({
//        NSView *view = [[NSView alloc]init];
//        //    view.wantsLayer = YES;
//        view.layer.backgroundColor = NSColor.redColor.CGColor;
//        view;
//    });
}

- (void)menuItemAction0{
    NSLog(@"load1 ---- ");
}
    
- (void)menuItemQuit{
    NSLog(@"load3 ---- ");
    [NSApplication.sharedApplication terminate:self];
    
}

- (void)hanldeStatusBtnClick:(NSButton *)sender{
    [self.firstPopover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSRectEdgeMaxY];
}

#pragma mark -lazy
//-(MainWindowController *)windowCtrl{
//    if (!_windowCtrl) {
//        _windowCtrl = [[MainWindowController alloc]initWithWindow:[NSWindow createWithTitle:@"999"]];
//    }
//    return _windowCtrl;
//}

- (NSPopover *)firstPopover{
    if(!_firstPopover) {
        _firstPopover = ({
            NSPopover *popover = [NSPopover popoverWithController:self.firstVC];
            popover;
        });
    }
    return _firstPopover;
}

- (FirstViewController *)firstVC{
    if(!_firstVC) {
        _firstVC = [[FirstViewController alloc]init];
        _firstVC.view.frame = CGRectMake(0, 0, kScreenWidth*0.2, 200);
    }
    return _firstVC;
}


@end
