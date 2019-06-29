//
//  NSTabView+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTabView+Helper.h"

@implementation NSTabView (Helper)

- (void)addItems:(NSArray<NSArray *> *)items{
    [items enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSViewController * controller = [[NSClassFromString(obj.firstObject) alloc] init];
        controller.title = controller.title ? : (obj[1] ? : @"");
        
        NSTabViewItem * item = [NSTabViewItem tabViewItemWithViewController:controller];
        item.view = controller.view;
        [self addTabViewItem:item];
    }];
}

@end
