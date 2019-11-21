//
//  NSView+Add.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/10/28.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <AppKit/AppKit.h>

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Add)

@property (nonatomic, assign) CGPoint center;

@property (nonatomic, strong) NSView *lineTop;
@property (nonatomic, strong) NSView *lineBottom;

@end

NS_ASSUME_NONNULL_END
