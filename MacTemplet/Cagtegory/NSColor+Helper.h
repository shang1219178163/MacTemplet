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

@property (class, nonatomic) NSColor *themeColor;
@property (class, nonatomic, readonly) NSColor *randomColor;
@property (class, nonatomic, readonly) NSColor *backgroudColor;
@property (class, nonatomic, readonly) NSColor *lineColor;
@property (class, nonatomic, readonly) NSColor *btnColor_N;
@property (class, nonatomic, readonly) NSColor *btnColor_H;
@property (class, nonatomic, readonly) NSColor *btnColor_D;
@property (class, nonatomic, readonly) NSColor *excelColor;
 
@property (class, nonatomic, readonly) NSColor *titleColor;
@property (class, nonatomic, readonly) NSColor *titleSubColor;

@property (class, nonatomic, readonly) NSColor *lightBlue;
@property (class, nonatomic, readonly) NSColor *lightOrange;
@property (class, nonatomic, readonly) NSColor *lightGreen;

@property (class, nonatomic, readonly) NSColor *titleColor3;
@property (class, nonatomic, readonly) NSColor *titleColor6;
@property (class, nonatomic, readonly) NSColor *titleColor9;

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
