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
    return [NSColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1];
}


@end
