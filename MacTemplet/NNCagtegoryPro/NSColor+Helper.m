//
//  NSColor+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSColor+Helper.h"

@implementation NSColor (Helper)

static NSColor * _themeColor = nil;
static NSColor * _backgroudColor = nil;
static NSColor * _lineColor = nil;
static NSColor * _btnColor_N = nil;
static NSColor * _btnColor_H = nil;
static NSColor * _btnColor_D = nil;
static NSColor * _excelColor = nil;
static NSColor * _titleColor = nil;
static NSColor * _titleSubColor = nil;

static NSColor * _lightBlue = nil;
static NSColor * _lightOrange = nil;
static NSColor * _lightGreen = nil;

static NSColor * _titleColor3 = nil;
static NSColor * _titleColor6 = nil;
static NSColor * _titleColor9 = nil;

+ (void)setThemeColor:(NSColor *)themeColor{
    _themeColor = themeColor;
}

+ (NSColor *)themeColor{
    if (!_themeColor) {
        _themeColor = NSColorHexValue(0x0082e0);
    }
    return _themeColor;
}

+ (NSColor *)randomColor{
    CGFloat red = arc4random_uniform(256);
    CGFloat green = arc4random_uniform(256);
    CGFloat blue = arc4random_uniform(256);
    return [NSColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}

+ (NSColor *)backgroudColor{
    if (!_backgroudColor) {
        _backgroudColor = NSColorHexValue(0xE9E9E9);//233,233,233;
    }
    return _backgroudColor;
}

+ (NSColor *)lineColor{
    if (!_lineColor) {
        _lineColor = NSColorHexValue(0xBCBAC0);
    }
    return _lineColor;
}

+ (NSColor *)btnColor_N{
    if (!_btnColor_N) {
        _btnColor_N = NSColorHexValue(0xfea914);
    }
    return _btnColor_N;
}

+ (NSColor *)btnColor_H{
    if (!_btnColor_H) {
        _btnColor_H = NSColorHexValue(0xf1a013);
    }
    return _btnColor_H;
}

+ (NSColor *)btnColor_D{
    if (!_btnColor_D) {
        _btnColor_D = NSColorHexValue(0x999999);
    }
    return _btnColor_D;
}

+ (NSColor *)excelColor{
    if (!_excelColor) {
        _excelColor = [NSColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _excelColor;
}

+ (NSColor *)titleColor{
    if (!_titleColor) {
        _titleColor = NSColorHexValue(0x333333);
    }
    return _titleColor;
}

+ (NSColor *)titleSubColor{
    if (!_titleSubColor) {
        _titleSubColor = NSColorHexValue(0x999999);
    }
    return _titleSubColor;
}

+ (NSColor *)lightBlue{
    if (!_lightBlue) {
        _lightBlue = NSColorHexValue(0x29B5FE);
    }
    return _lightBlue;
}

+ (NSColor *)lightOrange{
    if (!_lightOrange) {
        _lightOrange = NSColorHexValue(0xFFBB50);
    }
    return _lightOrange;
}

+ (NSColor *)lightGreen{
    if (!_lightGreen) {
        _lightGreen = NSColorHexValue(0x1AC756);
    }
    return _lightGreen;
}

+ (NSColor *)titleColor3{
    if (!_titleColor) {
        _titleColor = NSColorHexValue(0x333333);
    }
    return _titleColor;
}

+ (NSColor *)titleColor6{
    if (!_titleColor) {
        _titleColor = NSColorHexValue(0x666666);
    }
    return _titleColor;
}

+ (NSColor *)titleColor9{
    if (!_titleColor) {
        _titleColor = NSColorHexValue(0x999999);
    }
    return _titleColor;
}

NSColor * NSColorDim(CGFloat White, CGFloat a){
    return [NSColor colorWithWhite:White alpha:a];////white 0-1为黑到白,alpha透明度
    //    return [NSColor colorWithWhite:0.2f alpha: 0.5];////white 0-1为黑到白,alpha透明度
}
#pragma mark- -十六进制颜色
NSColor * NSColorRGBA(CGFloat r, CGFloat g, CGFloat b, CGFloat a){
    return [NSColor colorWithRed:r/255.0f
                           green:g/255.0f
                            blue:b/255.0f
                           alpha:a];
}

NSColor * NSColorHexValueAlpha(NSInteger hex, CGFloat alpha){
    return [NSColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0
                           green:((hex & 0xFF00) >> 8)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:alpha];
}

NSColor * NSColorHexValue(NSInteger hex){
    return NSColorHexValueAlpha(hex, 1.0);
}

NSColor * NSColorHexAlpha(NSString *hex, CGFloat alpha){
    return [NSColor colorWithHexString:hex alpha:alpha];
}

NSColor * NSColorHex(NSString *hex){
    return [NSColor colorWithHexString:hex alpha:1.0];
}

NSArray * RGBAFromColor(NSColor *color){
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

/**
 判断颜色是不是亮色
 */
BOOL isLightColor(NSColor *color){
    NSArray *components = RGBAFromColor(color);
    //    DDLog(@"%f %f %f", components[0], components[1], components[2]);
    CGFloat sum = [[components valueForKeyPath:kArr_sum_float] floatValue];
    bool isLight = sum < 382 ? false : true;
    return isLight;
}

+ (NSColor *)colorWithHexString:(NSString *)colorStr alpha:(CGFloat)alpha{
    NSString *cString = [[colorStr stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet] uppercaseString];
    
    // String should be 6 or 8 characters
    if (cString.length < 6) {
        return NSColor.clearColor;
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return NSColor.clearColor;
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [NSColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:1.0f];
}



@end
