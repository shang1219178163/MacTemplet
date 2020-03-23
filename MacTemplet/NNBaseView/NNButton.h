//
//  HHButton.h
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/20.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_OPTIONS(NSInteger, NNControlState) {
    NNControlStateNormal       = 1 << 0,
    NNControlStateHighlighted  = 1 << 1,
    NNControlStateDisabled     = 1 << 2,
    NNControlStateSelected     = 1 << 3,
    NNControlStateHover        = 1 << 4,
};

typedef NS_ENUM(NSInteger, NNButtonType) {
    NNButtonTypeText = 0,   //just text
    NNButtonType1 = 1,      //backgroud: white , text: blue, has bordColor
    NNButtonType2 = 2,      //backgroud: blue , text: white
};

NS_ASSUME_NONNULL_BEGIN


@interface NNButton : NSButton

+ (instancetype)buttonWithType:(NNButtonType)buttonType;

@property(nonatomic, assign) NNButtonType buttonType;

@property(nonatomic, assign) BOOL selected;
@property(nonatomic, assign) BOOL showHighlighted;

@property(nonatomic, strong) NSColor *titleColor;
@property(nonatomic, strong) NSColor *backgroundColor;
@property(nonatomic, strong) NSImage *backgroundImage;

- (void)setTitle:(nullable NSString *)title forState:(NNControlState)state;
- (void)setTitleColor:(nullable NSColor *)color forState:(NNControlState)state;

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(NNControlState)state;
- (void)setBackgroundImage:(nullable NSImage *)image forState:(NNControlState)state;

- (void)setBorderColor:(nullable NSColor *)color forState:(NNControlState)state;
- (void)setBorderWidth:(nullable NSNumber *)number forState:(NNControlState)state;
- (void)setCornerRadius:(nullable NSNumber *)number forState:(NNControlState)state;

- (nullable NSString *)titleForState:(NNControlState)state;
- (nullable NSColor *)titleColorForState:(NNControlState)state;
- (nullable NSAttributedString *)attributedStringForState:(NNControlState)state;

- (nullable NSImage *)backgroundImageForState:(NNControlState)state;

- (nullable NSColor *)borderColorForState:(NNControlState)state;
- (nullable NSNumber *)borderWidthForState:(NNControlState)state;
- (nullable NSNumber *)cornerRadiusForState:(NNControlState)state;

@end

NS_ASSUME_NONNULL_END



