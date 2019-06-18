
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
    NSRect selectionRect = NSInsetRect(self.bounds, 5.5, 5.5);
    [[NSColor colorWithCalibratedWhite:.72 alpha:1.0] setStroke];
    [[NSColor colorWithCalibratedWhite:.82 alpha:1.0] setFill];
    NSBezierPath *selectionPath = [NSBezierPath bezierPathWithRoundedRect:selectionRect xRadius:10 yRadius:10];
    [selectionPath fill];
    [selectionPath stroke];
}
//绘制背景
-(void)drawBackgroundInRect:(NSRect)dirtyRect{
    [super drawBackgroundInRect:dirtyRect];
//    [NSColor.greenColor setFill];
    NSRectFill(dirtyRect);
}

@end
