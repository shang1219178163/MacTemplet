//
//  NSColor+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSColor (Helper)

+ (NSColor *)randomColor;

FOUNDATION_EXPORT NSColor * NSColorDim(CGFloat White,CGFloat a);
#pragma mark- -十六进制颜色
FOUNDATION_EXPORT NSColor * NSColorRGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a);

FOUNDATION_EXPORT NSColor * NSColorHexValueAlpha(NSInteger hex, CGFloat alpha);

FOUNDATION_EXPORT NSColor * NSColorHexValue(NSInteger hexValue);

FOUNDATION_EXPORT NSColor * NSColorHexAlpha(NSString *hex, CGFloat alpha);

FOUNDATION_EXPORT NSColor * NSColorHex(NSString *hex);

FOUNDATION_EXPORT NSArray * RGBAFromColor(NSColor *color);

/**
 判断颜色是不是亮色
 */
BOOL isLightColor(NSColor *color);

+ (NSColor *)colorWithHexString:(NSString *)colorStr alpha:(CGFloat)alpha;

+ (NSColor *)colorWithHexString:(NSString *)colorString;


@end

NS_ASSUME_NONNULL_END
