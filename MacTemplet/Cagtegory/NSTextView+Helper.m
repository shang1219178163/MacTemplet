//
//  NSTextView+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTextView+Helper.h"

@implementation NSTextView (Helper)

static NSDictionary *_dic;

+ (NSDictionary *)dic{
    if (!_dic) {
        _dic = @{
                 @"x": @"cut:",
                 @"c": @"copy:",
                 @"v": @"paste:",
                 @"a": @"selectAll:",
                 @"z": @"keyDown:",
                 };
    }
    return _dic;
}

- (BOOL)performKeyEquivalent:(NSEvent *)event{
    if ((event.modifierFlags & NSEventModifierFlagDeviceIndependentFlagsMask) == NSEventModifierFlagCommand) {
        // The command key is the ONLY modifier key being pressed.
//        SEL selector = NSSelectorFromString(NSTextView.dic[event.charactersIgnoringModifiers]);
//        return [NSApp sendAction:selector to: self.window.firstResponder from:self];
        if ([event.charactersIgnoringModifiers isEqualToString:@"x"]) {
            return [NSApp sendAction:@selector(cut:) to: self.window.firstResponder from:self];
        } else if ([event.charactersIgnoringModifiers isEqualToString:@"c"]) {
            return [NSApp sendAction:@selector(copy:) to:self.window.firstResponder from:self];
        } else if ([event.charactersIgnoringModifiers isEqualToString:@"v"]) {
            return [NSApp sendAction:@selector(paste:) to:self.window.firstResponder from:self];
        } else if ([event.charactersIgnoringModifiers isEqualToString:@"a"]) {
            return [NSApp sendAction:@selector(selectAll:) to:self.window.firstResponder from:self];
        } else if ([event.charactersIgnoringModifiers isEqualToString:@"z"]) {
            return [NSApp sendAction:@selector(keyDown:) to:self.window.firstResponder from:self];
        }
    }
    return [super performKeyEquivalent:event];
}


@end
