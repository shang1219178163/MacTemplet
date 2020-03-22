//
//  NNButton.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/20.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NNButton.h"
#import "NSImage+Ext.h"

NSString * const kTitle = @"title";
NSString * const kTitleColor = @"titleColor";
NSString * const kBackgroundImage = @"backgroundImage";
NSString * const kAttributedTitle = @"AttributedTitle";

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

@property(nonatomic, assign) NNControlState buttonState;

@end


@implementation NNButton

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"enabled"];
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionNew context:nil];

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
        
    NSImage *image = self.backgroundImage ? : [NSImage imageWithColor:self.backgroundColor size:CGSizeMake(1, 1)];
    if (image) {
        [image drawInRect:self.bounds];
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

//+ (instancetype)buttonWithType:(NNButtonType)buttonType{
//    NNButton *btn = [[NNButton alloc]initWithFrame:CGRectZero];
//    switch (buttonType) {
//        case NNButtonType1:
//            btn = [[NNButton alloc]initWithFrame:CGRectZero];
//            btn.wantsLayer = true;
//            btn.layer.borderColor = NSColor.labelColor.CGColor;
//            btn.layer.borderWidth = 1.5;
//
//            break;
//        case NNButtonType2:
//            btn = [[NNButton alloc]initWithFrame:CGRectZero];
//            btn.wantsLayer = true;
//            btn.layer.borderColor = NSColor.labelColor.CGColor;
//            btn.layer.borderWidth = 1.5;
//
//            break;
//        default:
//
//            break;
//    }
//    return btn;
//}

- (void)setTitle:(nullable NSString *)title forState:(NNControlState)state {
    if (!title) {
        return;
    }
//    self.title = title;
    self.mdic[@(state)][kTitle] = title;
}

- (void)setTitleColor:(nullable NSColor *)color forState:(NNControlState)state {
    if (!color) {
        return;
    }
    self.mdic[@(state)][kTitleColor] = color;
}

- (void)setBackgroundImage:(nullable NSImage *)image forState:(NNControlState)state {
    if (!image) {
        return;
    }
    self.mdic[@(state)][kBackgroundImage] = image;
}

- (void)setAttributedTitle:(nullable NSAttributedString *)title forState:(NNControlState)state {
    if (!title) {
        return;
    }
//    self.title = title.string;
    self.mdic[@(state)][kAttributedTitle] = title;
}

- (nullable NSString *)titleForState:(NNControlState)state {
    NSString *result = self.mdic[@(state)][kTitle] ? : self.mdic[@(NNControlStateNormal)][kTitle];
    return result;
}

- (nullable NSColor *)titleColorForState:(NNControlState)state {
    NSColor *result = self.mdic[@(state)][kTitleColor] ? : self.mdic[@(NNControlStateNormal)][kTitleColor];
    return result;
}

- (nullable NSImage *)backgroundImageForState:(NNControlState)state {
    NSImage *result = self.mdic[@(state)][kBackgroundImage] ? : self.mdic[@(NNControlStateNormal)][kBackgroundImage];
    return result;
}

- (void)updateUIWithState:(NNControlState)state {
    self.mdicState = self.mdic[@(state)] ? : self.mdic[@(NNControlStateNormal)];
    self.title = self.mdicState[kTitle];
    self.titleColor = self.mdicState[kTitleColor];
    self.backgroundImage = self.mdicState[kBackgroundImage];
    
//    [self setNeedsDisplay];
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
                        kBackgroundImage: [NSImage imageWithColor:self.backgroundColor size:CGSizeMake(1, 1)],
        }.mutableCopy;
    }
    return _mdicNormal;
}

- (NSMutableDictionary *)mdicHighlighted{
    if (!_mdicHighlighted) {
        _mdicHighlighted = @{kTitle: self.title,
                             kTitleColor: NSColor.labelColor,
                             kBackgroundImage: [NSImage imageWithColor:NSColor.systemBlueColor size:CGSizeMake(1, 1)],

        }.mutableCopy;
    }
    return _mdicHighlighted;
}

- (NSMutableDictionary *)mdicDisabled{
    if (!_mdicDisabled) {
        _mdicDisabled = @{kTitle: self.title,
                          kTitleColor: NSColor.lightGrayColor,
                          kBackgroundImage: [NSImage imageWithColor:NSColor.whiteColor size:CGSizeMake(1, 1)],

        }.mutableCopy;
    }
    return _mdicDisabled;
}

- (NSMutableDictionary *)mdicSelected{
    if (!_mdicSelected) {
        _mdicSelected = @{kTitle: self.title,
                          kTitleColor: NSColor.labelColor,
                          kBackgroundImage: [NSImage imageWithColor:self.backgroundColor size:CGSizeMake(1, 1)],

        }.mutableCopy;
    }
    return _mdicSelected;
}

- (NSMutableDictionary *)mdicHover{
    if (!_mdicHover) {
        _mdicHover = @{kTitle: self.title,
                       kTitleColor: NSColor.labelColor,
                       kBackgroundImage: [NSImage imageWithColor:self.backgroundColor size:CGSizeMake(1, 1)],

        }.mutableCopy;
    }
    return _mdicHover;
}



@end
