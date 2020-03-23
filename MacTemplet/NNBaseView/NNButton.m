//
//  NNButton.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/20.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NNButton.h"
#import "NSImage+Ext.h"
#import "NSColor+Ext.h"

NSString * const kTitle = @"title";
NSString * const kTitleColor = @"titleColor";
NSString * const kBackgroundImage = @"backgroundImage";
NSString * const kAttributedTitle = @"AttributedTitle";
NSString * const kBorderColor = @"BorderColor";
NSString * const kBorderWidth = @"BorderWidth";
NSString * const kCornerRadius = @"CornerRadius";

@interface NNButton ()

//@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL hover;
@property(nonatomic, assign) BOOL mouseUp;

@property(nonatomic, strong) NSTrackingArea *trackingArea;

@property(nonatomic, strong) NSMutableDictionary *mdic;
@property(nonatomic, strong) NSMutableDictionary *mdicState;

@property(nonatomic, strong) NSMutableDictionary *mdicNormal;
@property(nonatomic, strong) NSMutableDictionary *mdicHighlighted;
@property(nonatomic, strong) NSMutableDictionary *mdicDisabled;
@property(nonatomic, strong) NSMutableDictionary *mdicSelected;
@property(nonatomic, strong) NSMutableDictionary *mdicHover;

@property(nonatomic, assign, readwrite) NNControlState buttonState;

@end


@implementation NNButton

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"enabled"];
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];
        
        self.wantsLayer = true;
    }
    return self;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
        
//    self.isHighlighted
//    self.enabled
    // Drawing code here.
//    NSColor *backgroundColor = self.backgroundColor ? : NSColor.whiteColor;
//    [backgroundColor set];
//    NSRectFill(self.bounds);
        
    
//    NSColor *backgroundColor = self.backgroundColor ? : NSColor.whiteColor;
    NSImage *image = self.backgroundImage ? : [NSImage imageWithColor:NSColor.whiteColor];
    if (image) {
        [image drawInRect:self.bounds];
//        CGRect rect = CGRectMake(self.layer.borderWidth, self.layer.borderWidth, CGRectGetWidth(self.bounds) - self.layer.borderWidth*2, CGRectGetHeight(self.bounds) - self.layer.borderWidth*2);
//        [image drawInRect:rect];
    }
        
    if (self.title) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle defaultParagraphStyle]mutableCopy];
        paraStyle.alignment = self.alignment ? self.alignment : NSTextAlignmentCenter;
        
        NSDictionary *attrDic = @{NSParagraphStyleAttributeName: paraStyle,
                                  NSForegroundColorAttributeName: self.titleColor ? : NSColor.labelColor,
                                  NSFontAttributeName: self.font,
                                }.mutableCopy;
        
        NSAttributedString *attString = [[NSAttributedString alloc]initWithString:self.title attributes:attrDic];
        CGFloat fontHeight = ceil(self.font.boundingRectForFont.size.height);
        CGFloat gapY = CGRectGetMidY(self.bounds) - fontHeight/2;
        [attString drawInRect:NSMakeRect(0, gapY, self.frame.size.width, fontHeight)];
    }
}

- (void)viewWillMoveToSuperview:(NSView *)newSuperview {
    [super viewWillMoveToSuperview:newSuperview];
    [self updateUIWithState:self.buttonState];
}

- (void)updateTrackingAreas {
    [super updateTrackingAreas];
    if(self.trackingArea) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    NSTrackingAreaOptions options = NSTrackingInVisibleRect | NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways;
    self.trackingArea = [[NSTrackingArea alloc] initWithRect:self.bounds options:options owner:self userInfo:nil];

    [self addTrackingArea:self.trackingArea];
//    DDLog(@"%@", self.trackingAreas);
}

#pragma -NSEvent
- (void)mouseEntered:(NSEvent *)theEvent {
    self.hover = true;
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.hover = false;
}

- (void)mouseDown:(NSEvent *)event {
    self.mouseUp = false;
}

- (void)mouseUp:(NSEvent *)event {
    self.mouseUp = true;
}

#pragma mark -observe

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    NSNumber *valueNew = change[NSKeyValueChangeNewKey];
    if ([keyPath isEqualToString:@"enabled"]) {
        self.buttonState = valueNew.boolValue == false ? NNControlStateDisabled : NNControlStateNormal;
    }
}

#pragma mark -funtions

+ (instancetype)buttonWithType:(NNButtonType)buttonType{
    NNButton *sender = [[NNButton alloc] initWithFrame:CGRectZero];
    sender.buttonType = buttonType;

    [sender setTitle:@"NNButton" forState:NNControlStateNormal];
    [sender setTitleColor:NSColor.systemBlueColor forState:NNControlStateNormal];
    switch (buttonType) {
        case NNButtonType1:
        {
            [sender setTitleColor:NSColor.labelColor forState:NNControlStateNormal];
//            [sender setBorderColor:NSColor.labelColor forState:NNControlStateNormal];
        }
            break;
        case NNButtonType2:
        {
            [sender setTitleColor:NSColor.whiteColor forState:NNControlStateNormal];
            
            NSImage *image = [NSImage imageWithColor:[NSColor hexValue:0x29B5FE alpha:1]];
            [sender setBackgroundImage:image forState:NNControlStateNormal];
        }
            break;
        default:
            break;
    }
    return sender;
}

- (void)setTitle:(nullable NSString *)title forState:(NNControlState)state {
    if (!title) {
        return;
    }
    if (state == NNControlStateNormal) {
        self.title = title;
        self.mdic[@(NNControlStateHover)][kTitle] = title;
        self.mdic[@(NNControlStateSelected)][kTitle] = title;
        self.mdic[@(NNControlStateHighlighted)][kTitle] = title;
        self.mdic[@(NNControlStateDisabled)][kTitle] = title;
    }
    self.mdic[@(state)][kTitle] = title;
}

- (void)setTitleColor:(nullable NSColor *)color forState:(NNControlState)state {
    if (!color) {
        return;
    }
    if (state == NNControlStateNormal) {
        self.titleColor = color;
        self.mdic[@(NNControlStateHover)][kTitleColor] = color;
        self.mdic[@(NNControlStateHover)][kBorderColor] = color;
    }
    self.mdic[@(state)][kTitleColor] = color;
    self.mdic[@(state)][kBorderColor] = color;
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(NNControlState)state {
    if (!title) {
        return;
    }
    if (state == NNControlStateNormal) {
        self.title = title.string;
        self.mdic[@(NNControlStateHover)][kAttributedTitle] = title;
        self.mdic[@(NNControlStateSelected)][kAttributedTitle] = title;
        self.mdic[@(NNControlStateHighlighted)][kAttributedTitle] = title;
        self.mdic[@(NNControlStateDisabled)][kAttributedTitle] = title;
    }
    self.mdic[@(state)][kAttributedTitle] = title;
}

- (void)setBackgroundImage:(nullable NSImage *)image forState:(NNControlState)state {
    if (!image) {
        return;
    }
    if (state == NNControlStateNormal) {
        self.mdic[@(NNControlStateHover)][kBackgroundImage] = image;
        self.mdic[@(NNControlStateSelected)][kBackgroundImage] = image;
        self.mdic[@(NNControlStateHighlighted)][kBackgroundImage] = image;
        self.mdic[@(NNControlStateDisabled)][kBackgroundImage] = image;
    }
    self.mdic[@(state)][kBackgroundImage] = image;
}

- (void)setBorderColor:(nullable NSColor *)color forState:(NNControlState)state {
    if (!color) {
        return;
    }
    if (state == NNControlStateNormal) {
        self.mdic[@(NNControlStateHover)][kBorderColor] = color;
        self.mdic[@(NNControlStateSelected)][kBorderColor] = color;
        self.mdic[@(NNControlStateHighlighted)][kBorderColor] = color;
        self.mdic[@(NNControlStateDisabled)][kBorderColor] = color;
    }
    self.mdic[@(state)][kBorderColor] = color;
}

- (void)setBorderWidth:(nullable NSNumber *)number forState:(NNControlState)state {
    if (!number) {
        return;
    }
    if (state == NNControlStateNormal) {
        self.mdic[@(NNControlStateHover)][kBorderWidth] = number;
        self.mdic[@(NNControlStateSelected)][kBorderWidth] = number;
        self.mdic[@(NNControlStateHighlighted)][kBorderWidth] = number;
        self.mdic[@(NNControlStateDisabled)][kBorderWidth] = number;
    }
    self.mdic[@(state)][kBorderWidth] = number;
}

- (void)setCornerRadius:(nullable NSNumber *)number forState:(NNControlState)state {
    if (!number) {
        return;
    }
    if (state == NNControlStateNormal) {
        self.mdic[@(NNControlStateHover)][kCornerRadius] = number;
        self.mdic[@(NNControlStateSelected)][kCornerRadius] = number;
        self.mdic[@(NNControlStateHighlighted)][kCornerRadius] = number;
        self.mdic[@(NNControlStateDisabled)][kCornerRadius] = number;
    }
    self.mdic[@(state)][kCornerRadius] = number;
}

- (nullable NSString *)titleForState:(NNControlState)state {
    NSString *result = self.mdic[@(state)][kTitle] ? : self.mdic[@(NNControlStateNormal)][kTitle];
    return result;
}

- (nullable NSColor *)titleColorForState:(NNControlState)state {
    NSColor *result = self.mdic[@(state)][kTitleColor] ? : self.mdic[@(NNControlStateNormal)][kTitleColor];
    return result;
}

- (nullable NSAttributedString *)attributedStringForState:(NNControlState)state {
    NSAttributedString *result = self.mdic[@(state)][kAttributedTitle] ? : self.mdic[@(NNControlStateNormal)][kAttributedTitle];
    return result;
}

- (nullable NSImage *)backgroundImageForState:(NNControlState)state {
    NSImage *result = self.mdic[@(state)][kBackgroundImage] ? : self.mdic[@(NNControlStateNormal)][kBackgroundImage];
    return result;
}

- (nullable NSColor *)borderColorForState:(NNControlState)state {
    NSColor *result = self.mdic[@(state)][kBorderColor] ? : self.mdic[@(NNControlStateNormal)][kBorderColor];
    return result;
}

- (nullable NSNumber *)borderWidthForState:(NNControlState)state {
    NSNumber *result = self.mdic[@(state)][kBorderColor] ? : self.mdic[@(NNControlStateNormal)][kBorderColor];
    return result;
}

- (nullable NSNumber *)cornerRadiusForState:(NNControlState)state {
    NSNumber *result = self.mdic[@(state)][kCornerRadius] ? : self.mdic[@(NNControlStateNormal)][kCornerRadius];
    return result;
}

- (void)updateUIWithState:(NNControlState)state {
    if (state == NNControlStateHighlighted && self.showHighlighted == false) {
        return;
    }
    
    self.mdicState = self.mdic[@(state)] ? : self.mdic[@(NNControlStateNormal)];
    self.title = self.mdicState[kTitle];
    self.titleColor = self.mdicState[kTitleColor];
    self.backgroundImage = self.mdicState[kBackgroundImage];
        
//    self.layer.borderColor = [self.mdicState[kBorderColor] CGColor];
//    self.layer.borderWidth = [self.mdicState[kBorderWidth] floatValue];
//    self.layer.cornerRadius = [self.mdicState[kCornerRadius] floatValue];
        
    switch (self.buttonType) {
        case NNButtonType1:
        {
            if (state == NNControlStateDisabled) {
                self.layer.borderColor = NSColor.lightGrayColor.CGColor;
                
            } else {
                NSColor *borderColor = self.mdicState[kBorderColor];
                if (CGColorEqualToColor(NSColor.clearColor.CGColor, borderColor.CGColor) == false) {
                    self.layer.borderColor = [borderColor CGColor];
                }
            }
            NSNumber *borderWidth = self.mdicState[kBorderWidth];
            if (borderWidth.floatValue > 0) {
                self.layer.borderWidth = borderWidth.floatValue;
            }
            
            NSNumber *cornerRadius = self.mdicState[kCornerRadius];
            if (cornerRadius.floatValue > 0) {
                self.layer.cornerRadius = cornerRadius.floatValue;
            }
        }
            break;
        case NNButtonType2:
        {
            if (state == NNControlStateDisabled) {
                self.titleColor = NSColor.whiteColor;
                self.backgroundImage = [NSImage imageWithColor:NSColor.lightGrayColor];
            }
        }
            break;
        default:
            self.layer.borderColor = NSColor.clearColor.CGColor;
            self.layer.borderWidth = 0;
            self.layer.cornerRadius = 0;

            break;
    }
    [self setNeedsDisplay];
}

#pragma mark -set

- (void)setSelected:(BOOL)selected{
    _selected = selected;
    if (!self.enabled) {
        return;
    }
    self.buttonState = selected ? NNControlStateSelected : NNControlStateNormal;
}

- (void)setHover:(BOOL)hover{
    _hover = hover;
    if (!self.enabled) {
        return;
    }
    
    if (hover) {
        self.buttonState = NNControlStateHover;
    } else {
        self.buttonState = self.selected ? NNControlStateSelected : NNControlStateNormal;
    }
}

- (void)setMouseUp:(BOOL)mouseUp{
    _mouseUp = mouseUp;
    if (!self.enabled) {
        return;
    }
    
    if (mouseUp) {
        self.buttonState = self.selected ? NNControlStateSelected : NNControlStateNormal;

    } else {
        self.buttonState = NNControlStateHighlighted;
    }
    
    if (self.hover && self.enabled && mouseUp) {
        NSString *selString = NSStringFromSelector(self.action);
        if ([selString hasSuffix:@":"]) {
            [self.target performSelector:self.action withObject:self afterDelay:0.f];
        } else {
            [self.target performSelector:self.action withObject:nil afterDelay:0.f];
        }
    }
}

- (void)setButtonState:(NNControlState)buttonState{
    _buttonState = buttonState;

    [self updateUIWithState:buttonState];
}

#pragma mark -lazy

- (NSMutableDictionary *)mdic{
    if (!_mdic) {
        _mdic = @{@(NNControlStateNormal): self.mdicNormal,
                  @(NNControlStateHighlighted): self.mdicHighlighted,
                  @(NNControlStateDisabled): self.mdicDisabled,
                  @(NNControlStateSelected): self.mdicSelected,
                  @(NNControlStateHover): self.mdicHover,
        }.mutableCopy;
    }
    return _mdic;
}

- (NSMutableDictionary *)mdicNormal{
    if (!_mdicNormal) {
        _mdicNormal = @{kTitle: self.title,
                        kTitleColor: NSColor.labelColor,
                        kBackgroundImage: [NSImage imageWithColor:NSColor.whiteColor],
                        kCornerRadius: @(0.0),
                        kBorderWidth: @(1.0),
                        kBorderColor: NSColor.clearColor,
        }.mutableCopy;
    }
    return _mdicNormal;
}

- (NSMutableDictionary *)mdicHighlighted{
    if (!_mdicHighlighted) {
        _mdicHighlighted = @{kTitle: self.title,
                             kTitleColor: NSColor.labelColor,
                             kBackgroundImage: [NSImage imageWithColor:NSColor.systemBlueColor],
                             kCornerRadius: @(0.0),
                             kBorderWidth: @(1.0),
                             kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicHighlighted;
}

- (NSMutableDictionary *)mdicDisabled{
    if (!_mdicDisabled) {
        _mdicDisabled = @{kTitle: self.title,
                          kTitleColor: NSColor.lightGrayColor,
                          kBackgroundImage: [NSImage imageWithColor:NSColor.whiteColor],
                          kCornerRadius: @(0.0),
                          kBorderWidth: @(1.0),
                          kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicDisabled;
}

- (NSMutableDictionary *)mdicSelected{
    if (!_mdicSelected) {
        _mdicSelected = @{kTitle: self.title,
                          kTitleColor: NSColor.labelColor,
                          kBackgroundImage: [NSImage imageWithColor:NSColor.whiteColor],
                          kCornerRadius: @(0.0),
                          kBorderWidth: @(1.0),
                          kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicSelected;
}

- (NSMutableDictionary *)mdicHover{
    if (!_mdicHover) {
        _mdicHover = @{kTitle: self.title,
                       kTitleColor: NSColor.labelColor,
                       kBackgroundImage: [NSImage imageWithColor:NSColor.whiteColor],
                       kCornerRadius: @(0.0),
                       kBorderWidth: @(1.0),
                       kBorderColor: NSColor.clearColor,

        }.mutableCopy;
    }
    return _mdicHover;
}



@end
