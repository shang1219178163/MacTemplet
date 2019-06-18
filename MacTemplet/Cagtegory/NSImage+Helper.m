//
//  NSImage+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/17.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSImage+Helper.h"

@implementation NSImage (Helper)

- (NSImage *)resize:(CGSize)to isPixels:(BOOL)isPixels{
    
    CGSize toSize = to;
    CGFloat screenScale = NSScreen.mainScreen.backingScaleFactor;
    
    if (isPixels) {
        toSize.width = to.width/screenScale;
        toSize.height = to.height/screenScale;
    }
    
    CGRect toRect = CGRectMake(0, 0, toSize.width, toSize.height);
    CGRect fromRect = CGRectMake(0, 0, self.size.width, self.size.height);
    NSImage * newImage = [[NSImage alloc]initWithSize:toRect.size];
    
    [newImage lockFocus];
    [newImage drawInRect:toRect fromRect:fromRect operation:NSCompositingOperationCopy fraction:1.0];
    [newImage unlockFocus];
    return newImage;
}

@end
