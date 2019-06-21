

//
//  NSMenu+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSMenu+Helper.h"
#import "NSMenuItem+Helper.h"

@implementation NSMenu (Helper)

- (NSMenuItem *)insertItemWithTitle:(NSString *)string keyEquivalent:(NSString *)charCode atIndex:(NSInteger)index handler:(void(^)(NSMenuItem *menuItem))handler{
    NSMenuItem * item = [self addItemWithTitle:@"Load1" action:nil keyEquivalent:charCode];
    [item addActionHandler:handler];
    return item;
}

- (NSMenuItem *)addItemWithTitle:(NSString *)string keyEquivalent:(NSString *)charCode handler:(void(^)(NSMenuItem *menuItem))handler{
    NSMenuItem * item = [self addItemWithTitle:string action:nil keyEquivalent:charCode];
    [item addActionHandler:handler];
    return item;
}

@end
