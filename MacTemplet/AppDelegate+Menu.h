//
//  AppDelegate+Menu.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Menu)

+ (void)setupMainMenu;

+ (void)setupStatusItem:(NSStatusItem *)statusItem popover:(NSPopover *)popover;

+ (NSStatusItem *)setupStatusItemPopover:(NSPopover *)popover;

@end

NS_ASSUME_NONNULL_END
