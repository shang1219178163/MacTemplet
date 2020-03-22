
//
//  HHButton.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HHButton.h"

@interface HHButton ()

@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL hover;
@property (nonatomic, assign) BOOL mouseUp;

@property (nonatomic, strong) NSTrackingArea *trackingArea;
@property (nonatomic, strong) NSImage *defaultImage;

@end

@implementation HHButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSColor *backgroundColor = self.backgroundColor ? : NSColor.whiteColor;
    [backgroundColor set];
    NSRectFill(self.bounds);
    
    if (self.image) {
        [self.image drawInRect:self.bounds];
    }
    
    if (self.title) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle defaultParagraphStyle]mutableCopy];
        paraStyle.alignment = self.alignment ? self.alignment : NSTextAlignmentCenter;
        
        NSDictionary *attrDic = @{
                                  NSFontAttributeName: self.font,
                                  NSForegroundColorAttributeName: self.titleColor ? : NSColor.blackColor,
                                  NSParagraphStyleAttributeName: paraStyle,
                                  };

        NSAttributedString *attString = [[NSAttributedString alloc]initWithString:self.title attributes:attrDic];
        CGFloat fontHeight = ceil(self.font.boundingRectForFont.size.height);
        CGFloat gapY = CGRectGetMidY(self.bounds) - fontHeight/2;
        [attString drawInRect:NSMakeRect(0, gapY, self.frame.size.width, fontHeight)];
//        [attString drawInRect:NSMakeRect(0, (self.frame.size.height - 30)*0.5, self.frame.size.width, 30)];
    }
    
}


- (instancetype)initWithFrame:(NSRect)frameRect {
    self = [super initWithFrame:frameRect];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInitialize];
    }
    return self;
}

- (void)viewWillMoveToSuperview:(NSView *)newSuperview {
    [super viewWillMoveToSuperview:newSuperview];
    [self updateButtonApperaceWithState:self.buttonState];
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
}

- (void)mouseEntered:(NSEvent *)theEvent {
    self.hover = YES;
//    if (!self.selected) {
        self.buttonState = NNButtonHoverState;
//    }
}

- (void)mouseExited:(NSEvent *)theEvent {
    self.hover = NO;
    if (!self.selected) {
        self.buttonState = NNButtonNormalState;
    }
}

- (void)mouseDown:(NSEvent *)event {
    self.mouseUp = NO;
    if (self.enabled && !self.selected) {
        self.buttonState = NNButtonHighlightState;
    }
}

- (void)mouseUp:(NSEvent *)event {
    self.mouseUp = YES;
    if (self.enabled) {
        if (self.canSelected && self.hover) {
            self.selected = !self.selected;
            self.buttonState = self.selected ? NNButtonSelectedState : NNButtonNormalState;
        } else {
            if (!self.selected) {
                self.buttonState = NNButtonNormalState;
            }
        }
        if (self.hover && self.enabled) {
            NSString *selString = NSStringFromSelector(self.action);
            if ([selString hasSuffix:@":"]) {
                [self.target performSelector:self.action withObject:self afterDelay:0.f];
            } else {
                [self.target performSelector:self.action withObject:nil afterDelay:0.f];
            }
        }
    }
}

#pragma mark - Private Methods

- (void)commonInitialize {
//    self.borderNormalWidth = (_borderNormalWidth == 0.f) ? 1.f : _borderNormalWidth;
//    self.borderHoverWidth = (_borderHoverWidth == 0.f) ? 1.f : _borderHoverWidth;
//    self.borderHighlightWidth = (_borderHighlightWidth == 0.f) ? 1.f : _borderHighlightWidth;
//    self.borderSelectedWidth = (_borderSelectedWidth == 0.f) ? 2.f : _borderSelectedWidth;
//
//    self.borderNormalColor = (_borderNormalColor == nil) ? NSColor.clearColor : _borderNormalColor;
//    self.borderHoverColor = (_borderHoverColor == nil) ? NSColor.clearColor : _borderHoverColor;
//    self.borderHighlightColor = (_borderHighlightColor == nil) ? NSColor.clearColor : _borderHighlightColor;
//    self.borderSelectedColor = (_borderSelectedColor == nil) ? NSColor.clearColor : _borderSelectedColor;
//
//    self.normalColor = (_normalColor == nil) ? NSColor.clearColor : _normalColor;
//    self.hoverColor = (_hoverColor == nil) ? NSColor.clearColor : _hoverColor;
//    self.highlightColor = (_highlightColor == nil) ? NSColor.clearColor : _highlightColor;
//    self.selectedColor = (_selectedColor == nil) ? NSColor.clearColor : _selectedColor;
//
//    self.backgroundNormalColor = (_backgroundNormalColor == nil) ? NSColor.clearColor : _backgroundNormalColor;
//    self.backgroundHoverColor = (_backgroundHoverColor == nil) ? NSColor.clearColor : _backgroundHoverColor;
//    self.backgroundHighlightColor = (_backgroundHighlightColor == nil) ? NSColor.clearColor : _backgroundHighlightColor;
//    self.backgroundSelectedColor = (_backgroundSelectedColor == nil) ? NSColor.clearColor : _backgroundSelectedColor;
    
    self.canSelected = YES;
    [self initializeUI];
}

- (void)initializeUI {
    self.wantsLayer = YES;
    [self setButtonType:NSButtonTypeMomentaryPushIn];
    self.bezelStyle = NSBezelStyleTexturedSquare;
    self.bordered = NO;
    [self setFontColor:self.normalColor];
}

- (void)setFontColor:(NSColor *)color {
    self.titleColor = color;
    [self setNeedsDisplay];

//    NSDictionary *attrDict = @{NSForegroundColorAttributeName: color,
//
//    };
//    self.attributedTitle = [[NSAttributedString alloc]initWithString:self.title attributes:attrDict];
//    return;
    
//    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithAttributedString: self.attributedTitle];
//    if (attString.length == 0) {
//        return;
//    }
//    NSDictionary *attributes = [attString attributesAtIndex:0 effectiveRange:nil];
//    if ([attributes[NSForegroundColorAttributeName] isEqual:color]) {
//        return;
//    }
//    NSRange titleRange = NSMakeRange(0, attString.length);
//    [attString addAttribute:NSForegroundColorAttributeName value:NSColor.redColor range:titleRange];
//    self.attributedTitle = attString;
}

- (void)setBackgroundColor:(NSColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    
    [self setNeedsDisplay];
}

- (void)updateButtonApperaceWithState:(NNButtonState)state {
    
    CGFloat cornerRadius = 0.f;
    CGFloat borderWidth = 0.f;
    NSColor *borderColor = nil;
    NSColor *themeColor = nil;
    NSColor *backgroundColor = nil;
    switch (state) {
        case NNButtonNormalState: {
            cornerRadius = self.cornerNormalRadius > 0 ? self.cornerNormalRadius : self.layer.cornerRadius;
            borderWidth = self.borderNormalWidth > 0 ? self.borderNormalWidth : self.layer.borderWidth;
            borderColor = self.borderNormalColor ? : [NSColor colorWithCGColor: self.layer.borderColor];
            themeColor = self.normalColor;
            backgroundColor = self.backgroundNormalColor ? : self.backgroundColor;
            if (self.normalImage != nil) {
                self.defaultImage = self.normalImage;
            }
            break;
        }
        case NNButtonHoverState: {
            cornerRadius = self.cornerHoverRadius > 0 ? self.cornerHoverRadius : self.layer.cornerRadius;
            borderWidth = self.borderHoverWidth > 0 ? self.borderHoverWidth : self.layer.borderWidth;
            borderColor = self.borderHoverColor ? : [NSColor colorWithCGColor: self.layer.borderColor];
            themeColor = self.hoverColor;
            backgroundColor = self.backgroundHoverColor ? : self.backgroundColor;
            if (self.hoverImage != nil) {
                self.defaultImage = self.hoverImage;
            }
        }
            break;
        case NNButtonHighlightState: {
            cornerRadius = self.cornerHighlightRadius > 0 ? self.cornerHighlightRadius : self.layer.cornerRadius;
            borderWidth = self.borderHighlightWidth > 0 ? self.borderHighlightWidth : self.layer.borderWidth;
            borderColor = self.borderHighlightColor ? : [NSColor colorWithCGColor: self.layer.borderColor];
            themeColor = self.highlightColor;
            backgroundColor = self.backgroundHighlightColor ? : self.backgroundColor;
            if (self.highlightImage != nil) {
                self.defaultImage = self.highlightImage;
            }
        }
            break;
        case NNButtonSelectedState: {
            cornerRadius = self.cornerSelectedRadius > 0 ? self.cornerSelectedRadius : self.layer.cornerRadius;
            borderWidth = self.borderSelectedWidth > 0 ? self.borderSelectedWidth : self.layer.borderWidth;
            borderColor = self.borderSelectedColor ? : [NSColor colorWithCGColor: self.layer.borderColor];
            themeColor = self.selectedColor;
            backgroundColor = self.backgroundSelectedColor ? : self.backgroundColor;
            if (self.selectedImage != nil) {
                self.defaultImage = self.selectedImage;
            }
        }
            break;
    }
    if (self.defaultImage) {
        self.image = self.defaultImage;
    }
    [self setFontColor:themeColor];
    self.backgroundColor = backgroundColor;

    if (self.hasBorder) {
//        DDLog(@"%@_%@_%@", @(cornerRadius), @(borderWidth), borderColor);
        self.layer.cornerRadius = cornerRadius;
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = borderColor.CGColor;
    } else {
        self.layer.cornerRadius = 0.f;
        self.layer.borderWidth = 0.f;
        self.layer.borderColor = NSColor.clearColor.CGColor;
    }
}

#pragma mark - Setter

- (void)setCanSelected:(BOOL)canSelected {
    _canSelected = canSelected;
    [self updateButtonApperaceWithState:self.buttonState];
}

- (void)setHasBorder:(BOOL)hasBorder {
    _hasBorder = hasBorder;
    [self updateButtonApperaceWithState:self.buttonState];
}

- (void)setButtonState:(NNButtonState)state {
    if (_buttonState == state) {
        return;
    }
    _buttonState = state;
    self.selected = (state == NNButtonSelectedState);
    [self updateButtonApperaceWithState:state];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    [self setFontColor:self.normalColor];
}


@end
