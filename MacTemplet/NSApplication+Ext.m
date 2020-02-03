//
//  NSApplication+Ext.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/2/3.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NSApplication+Ext.h"

#import <AppKit/AppKit.h>


@implementation NSApplication (Ext)

+ (void)setIsSwift:(BOOL)isSwift{
    [NSUserDefaults.standardUserDefaults setBool:isSwift forKey:kIsSwift];
    [NSUserDefaults.standardUserDefaults synchronize];
}

+ (BOOL)isSwift{
    BOOL isSwift = [NSUserDefaults.standardUserDefaults boolForKey:kIsSwift];
    return isSwift;
}

@end
