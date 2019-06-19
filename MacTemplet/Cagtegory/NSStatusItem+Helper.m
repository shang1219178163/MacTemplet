//
//  NSStatusItem+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSStatusItem+Helper.h"

@implementation NSStatusItem (Helper)

+ (instancetype)createStatusItemImageName:(nullable NSString *)imageName{
    
    NSImage * image = [NSImage imageNamed:imageName];
    
    NSStatusItem *statusItem = ({
        NSStatusBar *statusBar = NSStatusBar.systemStatusBar;
        
        NSStatusItem *item = [statusBar statusItemWithLength:NSSquareStatusItemLength];
        item.button.cell.highlighted = true;
        item.button.image = image ? : NSApplication.appIcon;
        item.button.toolTip = NSApplication.appName;
        
        item;
    });
    
    return statusItem;
}


@end
