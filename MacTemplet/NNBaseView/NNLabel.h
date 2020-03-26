//
//  NNLabel.h
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/26.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, NSContentVerticalAlignment) {
    NSContentVerticalAlignmentTop      = 0,
    NSContentVerticalAlignmentCenter    = 1,
    NSContentVerticalAlignmentBottom     = 2,
};

@interface NNLabel : NSView

@property(nullable, nonatomic,copy)   NSString           *text; // default is nil
@property(nonatomic, strong) NSFont      *font; // default is nil (system font 17 plain)
@property(nonatomic, strong) NSColor     *textColor; // default is labelColor
@property(nonatomic, assign) NSTextAlignment    textAlignment;   // default is NSTextAlignmentLeft
/// 整体内容垂直对齐方向
@property(nonatomic, assign) NSContentVerticalAlignment    contentVerticalAlignment;   // default is NSContentVerticalAlignmentTop

@property(nonatomic, assign)        NSLineBreakMode    lineBreakMode;   // default is NSLineBreakByTruncatingTail. used for single and multiple lines of text

// the underlying attributed string drawn by the label, if set, the label ignores the properties above.
@property(nullable, nonatomic,copy)   NSAttributedString *attributedText;  // default is nil

// the 'highlight' property is used by subclasses for such things as pressed states. it's useful to make it part of the base class as a user property

@property(nullable, nonatomic,strong)       NSColor *highlightedTextColor; // default is nil
@property(nonatomic,getter=isHighlighted)   BOOL     highlighted;          // default is NO

@property(nonatomic,getter=isUserInteractionEnabled) BOOL userInteractionEnabled;  // default is NO
@property(nonatomic,getter=isEnabled)                BOOL enabled;                 // default is YES. changes how the label is drawn
//@property(nonatomic) NSInteger numberOfLines;

//- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines;
//- (void)drawTextInRect:(CGRect)rect;

@property(nonatomic, copy) void(^mouseDownBlock)(NNLabel *sender);
///返回事件
- (void)actionBlock:(void(^)(NNLabel *sender))block;

@end

NS_ASSUME_NONNULL_END
