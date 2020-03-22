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
    NNButtonTypeCustom = 0,   // no button type
    NNButtonType1,  // standard system button
    NNButtonType2
};

NS_ASSUME_NONNULL_BEGIN

@interface NNButton : NSButton

@property(nonatomic, assign) BOOL selected;

@property(nonatomic, strong) NSColor *titleColor;
@property(nonatomic, strong) NSColor *backgroundColor;
@property(nonatomic, strong) NSImage *backgroundImage;

+ (instancetype)buttonWithType:(NNButtonType)buttonType;

- (void)setTitle:(nullable NSString *)title forState:(NNControlState)state;
- (void)setTitleColor:(nullable NSColor *)color forState:(NNControlState)state;

- (void)setBackgroundImage:(nullable NSImage *)image forState:(NNControlState)state;
- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(NNControlState)state;

- (nullable NSString *)titleForState:(NNControlState)state;
- (nullable NSColor *)titleColorForState:(NNControlState)state;
- (nullable NSImage *)backgroundImageForState:(NNControlState)state;


@end

NS_ASSUME_NONNULL_END
