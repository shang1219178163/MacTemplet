//
//  NSControl+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSControl (Helper)

- (void)addActionHandler:(void(^)(NSControl *control))handler forControlEvents:(NSEventMask)controlEvents;


@end

NS_ASSUME_NONNULL_END
