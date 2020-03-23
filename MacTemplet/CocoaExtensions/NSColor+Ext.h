//
//  NSColor+Ext.h
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/23.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import <AppKit/AppKit.h>


#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSColor (Ext)

@property(class, nonatomic, strong, readonly) NSColor *lightBlue;
@property(class, nonatomic, strong, readonly) NSColor *lightOrange;
@property(class, nonatomic, strong, readonly) NSColor *lightGreen;
@property(class, nonatomic, strong, readonly) NSColor *line;

+ (NSColor *)hexValue:(NSInteger)rgbValue alpha:(CGFloat)alpha;



@end

NS_ASSUME_NONNULL_END
