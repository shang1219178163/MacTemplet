//
//  NNButtonCell.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/21.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "NNButtonCell.h"

@implementation NNButtonCell

-(void)drawBezelWithFrame:(NSRect)frame inView:(NSView *)controlView{
    //// General Declarations
    [NSGraphicsContext.currentContext saveGraphicsState];

    //// Color Declarations
    NSColor *fillColor = [NSColor colorWithCalibratedRed: 0 green: 0.59 blue: 0.886 alpha: 1];

    //// Rectangle Drawing
    NSBezierPath* rectanglePath = [NSBezierPath bezierPathWithRect: NSMakeRect(8.5, 7.5, 85, 25)];
    [fillColor setFill];
    [rectanglePath fill];
    [NSGraphicsContext restoreGraphicsState];
}

@end
