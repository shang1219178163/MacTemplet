//
//  NSMenu+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMenu (Helper)

- (NSMenuItem *)insertItemWithTitle:(NSString *)string keyEquivalent:(NSString *)charCode atIndex:(NSInteger)index handler:(void(^)(NSMenuItem *menuItem))handler;

- (NSMenuItem *)addItemWithTitle:(NSString *)string keyEquivalent:(NSString *)charCode handler:(void(^)(NSMenuItem *menuItem))handler;
    
@end

NS_ASSUME_NONNULL_END
