//
//  NSMenuItem+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMenuItem (Helper)

- (void)addActionHandler:(void(^)(NSMenuItem *menuItem))handler;

- (instancetype)itemWithTitle:(NSString *)string keyEquivalent:(NSString *)charCode handler:(void(^)(NSMenuItem *menuItem))handler;

@end

NS_ASSUME_NONNULL_END
