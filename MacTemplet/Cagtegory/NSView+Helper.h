//
//  NSView+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSView (Helper)

- (void)getViewLayer;

+(NSImageView *)createImgViewRect:(CGRect)rect image:(id)image;

+(NSTextField *)createTextFieldRect:(CGRect)rect text:(NSString *)text placeholder:(NSString *)placeholder;

+(NSTextView *)createTextViewRect:(CGRect)rect text:(NSString *)text;

+(NSScrollView *)createScrollViewRect:(CGRect)rect;

+(NSTableView *)createTableViewRect:(CGRect)rect;

@end

NS_ASSUME_NONNULL_END
