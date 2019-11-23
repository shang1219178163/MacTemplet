//
//  AppDelegate+Menu.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate+Menu.h"

@implementation AppDelegate (Menu)

+ (void)setupMainMenu{
    
    //1.获取主目录
    NSMenu *mainMenu = [[NSMenu alloc]initWithTitle:@"mainMenu"];
    NSMenuItem *oneItem = ({
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"一级目录" action:nil keyEquivalent:@"O"];
        item.submenu = ({
            NSMenu *menu = [[NSMenu alloc] initWithTitle:@"二级目录"]; //这里设置一级目录的名字有效
            [menu addItemWithTitle:@"Load1" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            [menu addItemWithTitle:@"Load2" keyEquivalent:@"T" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            menu;
        });
        item;
    });
    
    
    NSMenuItem *oneItem3 = ({
        NSMenuItem *item = [NSMenuItem createWithTitle:@"Load3" keyEquivalent:@"T" handler:^(NSMenuItem * _Nonnull menuItem) {
                 DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                 
             }];
        item.submenu = ({
            NSMenu *menu = [[NSMenu alloc] initWithTitle:@"三级目录"];
            [menu addItemWithTitle:@"-30" keyEquivalent:@"T" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            [menu addItemWithTitle:@"-31" keyEquivalent:@"T" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            menu;
        });
        item;
    });
    
    NSMenuItem *twoItem = ({
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"一级目录" action:nil keyEquivalent:@"O"];
        item.submenu = ({
            NSMenu *menu = [[NSMenu alloc] initWithTitle:@"二级目录"]; //这里设置一级目录的名字有效
            [menu addItemWithTitle:@"1000" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            [menu addItemWithTitle:@"1001" keyEquivalent:@"T" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            menu;
        });
        item;
    });
    
    NSMenuItem *threeItem = ({
        NSMenuItem *item = [[NSMenuItem alloc] initWithTitle:@"一级目录" action:nil keyEquivalent:@"O"];
        item.submenu = ({
            NSMenu *menu = [[NSMenu alloc] initWithTitle:@"二级目录"]; //这里设置一级目录的名字有效
            [menu addItemWithTitle:@"2000" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            [menu addItemWithTitle:@"2001" keyEquivalent:@"T" handler:^(NSMenuItem * _Nonnull menuItem) {
                DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
                
            }];
            menu;
        });
        item;
    });
    
    [oneItem.submenu addItem:oneItem3];
    [mainMenu addItem:oneItem];
    [mainMenu addItem:twoItem];
    [mainMenu addItem:threeItem];
    NSApp.mainMenu = mainMenu;
}

+ (NSStatusItem *)setupStatusItem{
   
    NSStatusItem *statusItem = [NSStatusItem createWithImageName:nil];
//    statusItem.menu = ({
//        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"menu_right"];
//        [menu addItemWithTitle:@"保持为默认大小" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
//            DDLog(@"%@_%@_%@", menuItem.title, menuItem.keyEquivalent, @(NSApp.mainWindow.frame));
//            [NSUserDefaults.standardUserDefaults setObject: NSStringFromRect(NSApp.mainWindow.frame) forKey:kMainWindowFrame];
//            [NSUserDefaults.standardUserDefaults synchronize];
//            
//        }];
//        [menu addItemWithTitle:@"Load1" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
//            DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
//            
//        }];
//        [menu addItemWithTitle:@"退出" keyEquivalent:@"" handler:^(NSMenuItem * _Nonnull menuItem) {
//            [NSApplication.sharedApplication terminate:self];
//            
//        }];
//        menu;
//    });
    
//    statusItem.view = ({
//        NSImageView *view = [[NSImageView alloc]init];
//        //    view.wantsLayer = YES;
//        view.layer.backgroundColor = NSColor.redColor.CGColor;
//        view.image = NSApplication.appIcon;
//        view;
//    });
    DDLog(@"%@", @(statusItem.view.bounds));
    return statusItem;
}

@end
