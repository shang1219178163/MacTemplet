//
//  NSTabView+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTabView (Helper)


/**
 @param items
 @[@[@"FirstViewController", @"首页", ],
 @[@"SecondViewController", @"圈子",],
 @[@"ThirdViewController", @"消息",],
 
 ];
 */
- (void)addItems:(NSArray<NSArray *> *)items;

@end

NS_ASSUME_NONNULL_END
