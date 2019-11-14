//
//  NNTextFieldCell.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNTextFieldCell.h"

@implementation NNTextFieldCell

- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame{
    if (self.isTextAlignmentVerticalCenter == false) {
        return frame;
    }
    NSInteger offset = floor((NSHeight(frame)/2 - (self.font.ascender + self.font.descender)));
    return NSInsetRect(frame, 0.0, offset);
}

- (void)editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate event:(NSEvent *)event{
    [super editWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate event:event];
}

- (void)selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate start:(NSInteger)start length:(NSInteger)length{
    [super selectWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate start:start length:length];
}

- (void)drawInteriorWithFrame:(NSRect)frame inView:(NSView *)view{
    [super drawInteriorWithFrame: [self adjustedFrameToVerticallyCenterText:frame] inView:view];
}

@end
