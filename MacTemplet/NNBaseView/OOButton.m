//
//  OOButton.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/21.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "OOButton.h"
#import "NSImage+Ext.h"

@implementation OOButton


- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    NSColor *strokeColor = self.strokeColor ? : NSColor.redColor;
    NSColor *fillColor = self.fillColor ? : NSColor.orangeColor;

    self.lineWidth = 4;

    // Drawing code here.
    [strokeColor setStroke];
    [fillColor setFill];
    
    NSRect rect = CGRectMake(self.lineWidth, self.lineWidth, CGRectGetWidth(dirtyRect) - self.lineWidth*2, CGRectGetHeight(dirtyRect) - self.lineWidth*2);
    NSBezierPath *path = [NSBezierPath bezierPathWithOvalInRect:rect];
    path.lineWidth = self.lineWidth;
    [path stroke];
    [path fill];
    
    
    NSImage *image = self.image ? : [NSImage imageWithColor:self.fillColor size:CGSizeMake(1, 1)];
    if (image) {
//        [image drawInRect:self.bounds];
        [NSGraphicsContext saveGraphicsState];
//        NSBezierPath *path1 = [NSBezierPath bezierPathWithRoundedRect:rect
//                                                             xRadius:5
//                                                             yRadius:5];
        [path addClip];
        
        [image drawInRect:rect
                 fromRect:NSZeroRect
                operation:NSCompositingOperationSourceOver
                 fraction:1.0
           respectFlipped:true
                    hints:nil];
        [NSGraphicsContext restoreGraphicsState];
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





@end
