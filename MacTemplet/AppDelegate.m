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

@interface AppDelegate ()
@property (nonatomic, strong) NSWindow *window;

@property (nonatomic, strong) MainWindowController *windowCtrl;

@property (nonatomic, strong) NSPopover *popover;

@property (nonatomic, strong) NSStatusItem *statusItem; //必须应用、且强引用，否则不会显示。
@property (nonatomic, strong) NSMenu *dockMenu;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints"];
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"LAYOUT_CONSTRAINTS_NOT_SATISFIABLE"];

    NSString * controllerName = @"HomeViewController";
//    controllerName = @"FirstViewController";
//    controllerName = @"MainViewController";
    controllerName = @"BNTabViewController";
//    controllerName = @"CollectionViewController";
//    controllerName = @"JsonToModelController";
//    controllerName = @"BNTextViewContoller";
//    controllerName = @"ProppertyLazyController";
    controllerName = @"TabViewController";
    
    NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
    self.window.contentViewController = controller;
    [self.window makeKeyAndOrderFront:self];

    //    self.windowCtrl.window.contentViewController = controller;
    //    self.windowCtrl.window.title = NSApplication.appName;
    
//    DDLog(@"NSApplication.sharedApplication.mainWindow_%@", NSApplication.sharedApplication.mainWindow);
//    DDLog(@"NSApp.mainWindow_%@", NSApp.mainWindow);
//    DDLog(@"NSApp.keyWindow_%@", NSApp.keyWindow);
//    DDLog(@"NSApplication.windowDefault_%@", NSApplication.windowDefault);
    [NSUserDefaults.standardUserDefaults setObject:@(0) forKey: @"NSInitialToolTipDelay"];

//    id obj = [NSUserDefaults.standardUserDefaults objectForKey:kMainWindowFrame];
//    DDLog(@"%@", obj);
//    if (CGRectContainsRect(NSScreen.mainScreen.frame, NSRectFromString(obj))) {
//        [self.window setFrame:NSRectFromString(obj) display:false animate:false];
//    }
    
    [AppDelegate setupMainMenu];
    if (!self.statusItem) {
        self.statusItem = [AppDelegate setupStatusItem];
        @weakify(self);
        [self.statusItem.button addActionHandler:^(NSControl * _Nonnull control) {
            @strongify(self);
            NSButton *sender = (NSButton *)control;
            [self.popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSRectEdgeMaxY];
            
        }];
        
        [self.statusItem.button resignFirstResponder];

    }
    
//    NSDictionary *systemDic = [NSDictionary dictionaryWithContentsOfFile:@"/System/Library/CoreServices/SystemVersion.plist"];
//    DDLog(@"systemDic_%@", systemDic);
//
//    NSDictionary *infoDict = NSBundle.mainBundle.infoDictionary;
//    DDLog(@"infoDict_%@", infoDict);

}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *) sender{
    return YES;
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
    [NSUserDefaults.standardUserDefaults setObject: NSStringFromRect(self.window.frame) forKey:kMainWindowFrame];
    [NSUserDefaults.standardUserDefaults synchronize];
    
//    DDLog(@"%@", NSStringFromRect(self.window.frame));
}
/// 点击dock图标重新弹出窗口方法
- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag {
//    DDLog(@"%@,%@,hasVisibleWindows:%d", self.window, sender.mainWindow, flag);
    if (!flag){
        [NSApp activateIgnoringOtherApps:false];
        [self.window makeKeyAndOrderFront:self];
        return true;
    }
    return false;
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
-(NSWindow *)window{
    if (!_window) {
        _window = NSApplication.windowDefault;
        _window.title = NSApplication.appName;
        _window.contentMinSize = CGSizeMake(kScreenWidth*0.56, kScreenHeight*0.5);
    }
    return _window;
}

//-(MainWindowController *)windowCtrl{
//    if (!_windowCtrl) {
//        _windowCtrl = [[MainWindowController alloc]initWithWindow:[NSWindow createWithTitle:@"999"]];
//    }
//    return _windowCtrl;
//}

- (NSPopover *)popover{
    if(!_popover) {
        _popover = ({
            NSString * controllerName = @"FirstViewController";
            NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
            controller.view.frame = CGRectMake(0, 0, kScreenWidth*0.2, 200);
            NSPopover *popover = [NSPopover createWithController:controller];
//
            popover;
        });
    }
    return _popover;
}



@end
