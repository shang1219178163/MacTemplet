//
//  NSImage+Ext.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/20.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NSImage+Ext.h"
#import <AppKit/AppKit.h>

@implementation NSImage (Ext)

+(NSImage *)imageWithColor:(NSColor *)color size:(CGSize)size{
    NSImage *image = [[NSImage alloc] initWithSize:size];
    [image lockFocus];
    [color drawSwatchInRect:NSMakeRect(0, 0, size.width, size.height)];
    [image unlockFocus];
   return image;
}

@end
