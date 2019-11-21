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
/// NSControl
- (void)addActionHandler:(void(^)(NSControl *control))handler;
/// NSSegment
- (void)addActionHandler:(void(^)(NSControl *control))handler forTrackingMode:(NSSegmentSwitchTracking)trackingMode;

- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(NSEventMask)controlEvents;

@end

NS_ASSUME_NONNULL_END
