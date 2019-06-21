//
//  AppDelegate.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Menu.h"

#import "MainWindowController.h"
#import "FirstViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) MainWindowController *windowCtrl;

@property(nonatomic,strong) NSPopover *popover;
@property(nonatomic,strong) FirstViewController * firstVC;

@property (nonatomic,strong) NSStatusItem *statusItem; //必须应用、且强引用，否则不会显示。
@property (nonatomic,strong) NSMenu *dockMenu;


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
//    controllerName = @"CollectionViewController";

    NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
    NSApplication.windowDefault.contentViewController = controller;
    NSApplication.windowDefault.title = NSApplication.appName;
    //    self.windowCtrl.window.contentViewController = controller;
    //    self.windowCtrl.window.title = NSApplication.appName;
    
//    DDLog(@"%@",NSApplication.sharedApplication.mainWindow);
//    DDLog(@"%@",NSApp.mainWindow);
//    DDLog(@"%@",NSApplication.windowDefault);
    [NSUserDefaults.standardUserDefaults setObject:@(0) forKey: @"NSInitialToolTipDelay"];
    
    [AppDelegate setupMainMenu];
//    [AppDelegate setupStatusItem:self.statusItem popover:self.popover];
    if (!self.statusItem) {
        self.statusItem = [AppDelegate setupStatusItemPopover:self.popover];
    }

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

- (NSMenu *)applicationDockMenu:(NSApplication *)sender{
    return self.dockMenu;
}

#pragma mark -funtions

#pragma mark -addMainMenu


#pragma mark -addStatusItemRight

#pragma mark -dockMenu

-(NSMenu *)dockMenu{
    if (!_dockMenu) {
        _dockMenu = ({
            NSMenuItem *oneItem = ({
                NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"新的Dock目录" action:nil keyEquivalent:@"P"];
//                [item addActionHandler:^(NSMenuItem * _Nonnull menuItem) {
//                    DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
//
//                }];
                
                NSMenu *subMenu = [[NSMenu alloc] initWithTitle:@"一级目录"]; //这里设置一级目录的名字有效
                [subMenu addItemWithTitle:@"Load1" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
                    DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);

                }];
                [subMenu addItemWithTitle:@"Load2" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
                    DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);

                }];
                // NSMenuItem 有子菜单时,本身响应时间默认为显示e子菜单
                item.submenu = subMenu;
                
                item;
            });
            
            NSMenu *menu = [[NSMenu alloc] initWithTitle:@"DockMenu"];
            menu.autoenablesItems = false;
            [menu addItem:oneItem];

            menu;
        });
    }
    return _dockMenu;
}


#pragma mark -lazy
//-(MainWindowController *)windowCtrl{
//    if (!_windowCtrl) {
//        _windowCtrl = [[MainWindowController alloc]initWithWindow:[NSWindow createWithTitle:@"999"]];
//    }
//    return _windowCtrl;
//}

- (NSPopover *)popover{
    if(!_popover) {
        _popover = ({
            NSPopover *popover = [NSPopover popoverWithController:self.firstVC];
            popover;
        });
    }
    return _popover;
}

- (FirstViewController *)firstVC{
    if(!_firstVC) {
        _firstVC = [[FirstViewController alloc]init];
        _firstVC.view.frame = CGRectMake(0, 0, kScreenWidth*0.2, 200);
    }
    return _firstVC;
}


@end
