//
//  AppDelegate.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Menu.h"
#import <SwiftExpand-Swift.h>


@interface AppDelegate ()

@property (nonatomic, strong) NSWindow *window;

@property (nonatomic, strong) NSWindowController *windowCtrl;

@property (nonatomic, strong) NSPopover *popover;

@property (nonatomic, strong) NSStatusItem *statusItem; //必须应用、且强引用，否则不会显示。
@property (nonatomic, strong) NSMenu *dockMenu;


@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
//    [NSFont initializeMethod];
    
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"NSConstraintBasedLayoutVisualizeMutuallyExclusiveConstraints"];
    [NSUserDefaults.standardUserDefaults setBool:YES forKey:@"LAYOUT_CONSTRAINTS_NOT_SATISFIABLE"];
    [NSUserDefaults.standardUserDefaults setObject:@(0) forKey: @"NSInitialToolTipDelay"];

    NSString *vcNmae = @"HomeViewController";
//    vcNmae = @"FirstViewController";
//    vcNmae = @"MainViewController";
//    vcNmae = @"NNTabViewController";
//    vcNmae = @"CollectionViewController";
//    vcNmae = @"JsonToModelController";
//    vcNmae = @"NNTextViewContoller";
//    vcNmae = @"ProppertyLazyController";
//    vcNmae = @"MacTemplet.MapViewController";
//    vcNmae = @"MacTemplet.ShowViewController";
    
    NSViewController *controller = [[NSClassFromString(vcNmae) alloc] init];
    self.window.contentViewController = controller;
    [self.window makeKeyAndOrderFront:self];
    [NSApp activateIgnoringOtherApps:true];

//    self.window.opaque = false;
//    self.window.backgroundColor = [NSColor.whiteColor colorWithAlphaComponent:0.9];
//    self.windowCtrl.window.contentViewController = controller;
//    self.windowCtrl.window.title = NSApplication.appName;

    DDLog(@"NSApp.homeWindow_%@", NSApplication.homeWindow);
    DDLog(@"NSApplication.sharedApplication.mainWindow_%@", NSApplication.sharedApplication.mainWindow);
    DDLog(@"NSApp.mainWindow_%@", NSApp.mainWindow);
    DDLog(@"NSApp.keyWindow_%@", NSApp.keyWindow);
//    DDLog(@"NSApplication.windowDefault_%@", NSApplication.initWindow);

//    id obj = [NSUserDefaults.standardUserDefaults objectForKey:kMainWindowFrame];
//    DDLog(@"%@", obj);
//    if (CGRectContainsRect(NSScreen.mainScreen.frame, NSRectFromString(obj))) {
//        [self.window setFrame:NSRectFromString(obj) display:false animate:false];
//    }
    
    [AppDelegate setupMainMenu];
    if (!self.statusItem) {
        // statusItem.menu有值的时候,button方法不响应
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
    
//    NSString *one = nil;
//    NSString *two = @"";
//    DDLog(@"%@_%@", @(one.length), @(two.length));
    
    NSUserDefaults.defaults[@"aaa"] = @"啊啊啊";
    [NSUserDefaults synchronize];

    id obj = NSUserDefaults.defaults[@"aaa"];
    DDLog(@"_%@_", obj);
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
        _window = NSApplication.homeWindow;
//        _window.contentMinSize = CGSizeMake(kScreenWidth*0.55, kScreenHeight*0.5);
        _window.contentMinSize = CGSizeMake(NSScreen.sizeWidth*0.55, NSScreen.sizeHeight*0.5);
        _window.title = @"App代码助手";
    }
    return _window;
}

//-(NSWindowController *)windowCtrl{
//    if (!_windowCtrl) {
//        _windowCtrl = [[NSWindowController alloc]initWithWindow:[NSWindow createWithTitle:@"999"]];
//    }
//    return _windowCtrl;
//}

- (NSPopover *)popover{
    if(!_popover) {
        _popover = ({
            NSString *vcNmae = @"FirstViewController";
            NSViewController * controller = [[NSClassFromString(vcNmae) alloc] init];
            controller.view.frame = CGRectMake(0, 0, NSScreen.sizeWidth*0.2, 200);
            NSPopover *popover = [[NSPopover alloc] initWithVc:controller];
//
            popover;
        });
    }
    return _popover;
}



@end
