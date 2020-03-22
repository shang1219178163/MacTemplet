//
//  AAButton.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/21.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "AAButton.h"

@implementation AAButton

- (instancetype)initWithFrame:(NSRect)frameRect {
    if (self = [super initWithFrame:frameRect]) {
        [self setup];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _backgroundColor = [NSColor whiteColor];
    _shadowOffset = CGSizeZero;
    _cornerRadius = 4.f;
}

- (void)setTitle:(NSString *)title color:(NSColor *)textColor font:(CGFloat)fontsize{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attDic = @{
        NSParagraphStyleAttributeName: paraStyle,
        NSForegroundColorAttributeName: textColor,
        NSFontAttributeName:  [NSFont systemFontOfSize:fontsize],
            
    };
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:title attributes:attDic];
    self.attributedTitle = attString;
}

//- (void)setTitle:(NSString *)title color:(NSColor *)textColor font:(CGFloat)fontsize{
//    NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc] initWithString:title];
//    NSUInteger len = [attrTitle length];
//    NSRange range = NSMakeRange(0, len);
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//    paragraphStyle.alignment = NSTextAlignmentCenter;
//    [attrTitle addAttribute:NSForegroundColorAttributeName value:textColor
//                      range:range];
//    [attrTitle addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:fontsize]
//                      range:range];
//
//    [attrTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle
//                      range:range];
//    [attrTitle fixAttributesInRange:range];
//    [self setAttributedTitle:attrTitle];
//    attrTitle = nil;
//    [self setNeedsDisplay:YES];
//}

/**
 绘制方法由updateLayer替换
 */
- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
}

- (BOOL)wantsUpdateLayer {
    return YES;
}

- (void)updateLayer {
    //changed to the width or height of a single source pixel centered at the specified location.
    self.layer.contentsCenter = CGRectMake(0.5, 0.5, 0, 0);
    //setImage
    self.layer.backgroundColor = _backgroundColor.CGColor;
    self.layer.cornerRadius = _cornerRadius;
    if (!CGSizeEqualToSize(CGSizeZero, _shadowOffset)) {
        self.layer.masksToBounds = NO;
        self.layer.shadowColor = _backgroundColor.CGColor;
        self.layer.shadowOffset = CGSizeMake(1, 2);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 1;
    }
}

@end
