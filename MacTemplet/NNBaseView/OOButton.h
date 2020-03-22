//
//  OOButton.h
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/21.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
//#import "NNButton.h"

NS_ASSUME_NONNULL_BEGIN

/// [需求定制]绘制圆形图像,用于列表圆形头像显示
@interface OOButton : NSButton

@property(nonatomic, strong) NSColor *titleColor;
@property(nonatomic, strong) NSColor *backgroundColor;
@property(nonatomic, strong) NSImage *backgroundImage;

@property (nonatomic, strong) NSColor *strokeColor;
@property (nonatomic, strong) NSColor *fillColor;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) NSColor *lineColor;

@end

NS_ASSUME_NONNULL_END
