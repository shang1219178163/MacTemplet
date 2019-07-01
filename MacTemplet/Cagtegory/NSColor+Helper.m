//
//  NSColor+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSColor+Helper.h"

@implementation NSColor (Helper)

+ (NSColor *)randomColor{
    CGFloat red = arc4random_uniform(256);
    CGFloat green = arc4random_uniform(256);
    CGFloat blue = arc4random_uniform(256);
    return [NSColor colorWithRed:red/255.0
                           green:green/255.0
                            blue:blue/255.0
                           alpha:1];
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
    return [NSColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0
                           green:((hex & 0xFF00) >> 8)/255.0
                            blue:(hex & 0xFF)/255.0
                           alpha:1.0];
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
    //    NSLog(@"%f %f %f", components[0], components[1], components[2]);
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
