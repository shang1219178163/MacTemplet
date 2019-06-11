//
//  NSTextFieldCell+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTextFieldCell+Helper.h"

@implementation NSTextFieldCell (Helper)

//+ (void)initialize{
//    if (self == self.class) {
//        static dispatch_once_t onceToken;
//        dispatch_once(&onceToken, ^{
//            
//        });
//    }
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    if (sel == @selector(adjustedFrameToVerticallyCenter:)) {
//        class_addMethod(self.class, sel, class_getMethodImplementation(self, @selector(adjustedFrameToVerticallyCenter)), "name=CGRect:name=CGRect");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

- (CGRect)adjustedFrameToVerticallyCenter:(CGRect)rect {
    CGFloat fontSize = self.font.boundingRectForFont.size.height;
    NSInteger offset = floor((NSHeight(rect) - ceilf(fontSize))/2);
    NSRect centeredRect = NSInsetRect(rect, 0, offset);
    return centeredRect;
}

@end
