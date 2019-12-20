
//
//  NNTableRowView.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNTableRowView.h"

@implementation NNTableRowView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

//绘制选中状态的背景
-(void)drawSelectionInRect:(NSRect)dirtyRect{
    NSRect selectionRect = NSInsetRect(self.bounds, 0, 0);
//    [NSColor.redColor setStroke];
    [[NSColor colorWithCalibratedWhite:.82 alpha:1.0] setFill];
    [[NSColor colorWithCalibratedWhite:.82 alpha:1.0] setStroke];
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    
    NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:0 yRadius:0];
    selectionPath.lineWidth = 1.5;
    [selectionPath fill];
    [selectionPath stroke];
}

////绘制选中状态的背景
//-(void)drawSelectionInRect:(NSRect)dirtyRect{
//    NSRect selectionRect = NSInsetRect(self.bounds, 5.5, 5.5);
//    [[NSColor colorWithCalibratedWhite:.72 alpha:1.0] setStroke];
//    [[NSColor colorWithCalibratedWhite:.82 alpha:1.0] setFill];
//    NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:8 yRadius:10];
//    [selectionPath fill];
//    [selectionPath stroke];
//}
//绘制背景
-(void)drawBackgroundInRect:(NSRect)dirtyRect{
    [super drawBackgroundInRect:dirtyRect];

//    DDLog(@"backgroundColor:%@", self.backgroundColor);
    [NSColor.whiteColor setFill];
    NSRectFill(dirtyRect);
}

@end
