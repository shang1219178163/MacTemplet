//
//  NSImage+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/17.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSImage (Helper)

- (NSImage *)resize:(CGSize)to isPixels:(BOOL)isPixels;

- (CGSize)sizeFromImage:(NSImage *)image;

@end

NS_ASSUME_NONNULL_END
