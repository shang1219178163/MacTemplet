//
//  NSPopover+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSPopover+Helper.h"

@implementation NSPopover (Helper)

+(instancetype)popoverWithController:(NSViewController *)controller{
    assert([self isSubclassOfClass:NSPopover.class]);
    
    NSPopover *popover = [[NSPopover alloc]init];
    popover.appearance = [NSAppearance appearanceNamed:NSAppearanceNameAqua];
    popover.behavior = NSPopoverBehaviorTransient;
    popover.contentViewController = controller;
    return popover;
}

@end
