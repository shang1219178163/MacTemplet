//
//  NSSegmentedControl+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSegmentedControl (Helper)
/// 自定义字符串数组
@property (nonatomic, strong) NSArray<NSString *> *items;

@end

NS_ASSUME_NONNULL_END
