//
//  NSTextFieldCell+Hook.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTextFieldCell+Hook.h"
#import <objc/runtime.h>

@implementation NSTextFieldCell (Hook)

//+ (void)initialize{
//    if (self == self.class) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            SwizzleMethodInstance(self.class, @selector(editWithFrame:editor:delegate:event:), @selector(hook_editWithFrame:inView:editor:delegate:event:));
//            SwizzleMethodInstance(self.class, @selector(selectWithFrame:inView:editor:delegate:start:length:), @selector(hook_selectWithFrame:inView:editor:delegate:start:length:));
//            SwizzleMethodInstance(self.class, @selector(drawInteriorWithFrame:inView:), @selector(hook_drawInteriorWithFrame:inView:));
//            
//        });
//    }
//}
//
//- (BOOL)isTextAlignmentVerticalCenter{
//    return [objc_getAssociatedObject(self, _cmd) boolValue];
//}
//
//- (void)setIsTextAlignmentVerticalCenter:(BOOL)isTextAlignmentVerticalCenter{
//    objc_setAssociatedObject(self, @selector(isTextAlignmentVerticalCenter), @(isTextAlignmentVerticalCenter), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSRect)adjustedFrameToVerticallyCenterText:(NSRect)frame{
//    if (self.isTextAlignmentVerticalCenter == false) {
//        return frame;
//    }
//    NSInteger offset = floor((NSHeight(frame)/2 - (self.font.ascender + self.font.descender)));
//    return NSInsetRect(frame, 0.0, offset);
//}
//
//- (void)hook_editWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate event:(NSEvent *)event{
//    [super editWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate event:event];
//}
//
//- (void)hook_selectWithFrame:(NSRect)aRect inView:(NSView *)controlView editor:(NSText *)editor delegate:(id)delegate start:(NSInteger)start length:(NSInteger)length{
//    [super selectWithFrame:[self adjustedFrameToVerticallyCenterText:aRect] inView:controlView editor:editor delegate:delegate start:start length:length];
//}
//
//- (void)hook_drawInteriorWithFrame:(NSRect)frame inView:(NSView *)view{
//    [super drawInteriorWithFrame: [self adjustedFrameToVerticallyCenterText:frame] inView:view];
//}

@end

