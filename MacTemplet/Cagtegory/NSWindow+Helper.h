//
//  NSWindow+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSWindow (Helper)

+(NSWindow *)createWithTitle:(NSString *)title;

+(NSWindow *)createWithSize:(CGSize)size title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
