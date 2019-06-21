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
        NSMenuItem *item = [[NSMenuItem alloc]initWithTitle:@"Load3" keyEquivalent:@"T" handler:^(NSMenuItem * _Nonnull menuItem) {
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

+ (void)setupStatusItem:(NSStatusItem *)statusItem popover:(NSPopover *)popover{
    if (statusItem) {
        return;
    }
    
    statusItem = [NSStatusItem createStatusItemImageName:nil];
    statusItem.menu = ({
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"menu_right"];
        [menu addItemWithTitle:@"Load1" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
            DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
            
        }];
        [menu addItemWithTitle:@"退出" keyEquivalent:@"" handler:^(NSMenuItem * _Nonnull menuItem) {
            [NSApplication.sharedApplication terminate:self];
            
        }];
        menu;
    });
    
    [statusItem.button addActionHandler:^(NSControl * _Nonnull control) {
        NSButton *sender = (NSButton *)control;
        [popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSRectEdgeMaxY];
        
    } forControlEvents:NSEventMaskLeftMouseDown];
    //    statusItem.view = ({
    //        NSView *view = [[NSView alloc]init];
    //        //    view.wantsLayer = YES;
    //        view.layer.backgroundColor = NSColor.redColor.CGColor;
    //        view;
    //    });
    
}

+ (NSStatusItem *)setupStatusItemPopover:(NSPopover *)popover{
   
    NSStatusItem *statusItem = [NSStatusItem createStatusItemImageName:nil];
    statusItem.menu = ({
        NSMenu *menu = [[NSMenu alloc] initWithTitle:@"menu_right"];
        [menu addItemWithTitle:@"重置文件路径" keyEquivalent:@"E" handler:^(NSMenuItem * _Nonnull menuItem) {
            DDLog(@"%@_%@", menuItem.title, menuItem.keyEquivalent);
            [NSUserDefaults.standardUserDefaults removeObjectForKey:@""];
        }];
        [menu addItemWithTitle:@"退出" keyEquivalent:@"" handler:^(NSMenuItem * _Nonnull menuItem) {
            [NSApplication.sharedApplication terminate:self];
            
        }];
        menu;
    });
    
    [statusItem.button addActionHandler:^(NSControl * _Nonnull control) {
        NSButton *sender = (NSButton *)control;
        [popover showRelativeToRect:sender.bounds ofView:sender preferredEdge:NSRectEdgeMaxY];
        
    } forControlEvents:NSEventMaskLeftMouseDown];
    //    statusItem.view = ({
    //        NSView *view = [[NSView alloc]init];
    //        //    view.wantsLayer = YES;
    //        view.layer.backgroundColor = NSColor.redColor.CGColor;
    //        view;
    //    });
    
    return statusItem;
}

@end
