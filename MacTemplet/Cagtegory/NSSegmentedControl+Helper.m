//
//  NSSegmentedControl+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSSegmentedControl+Helper.h"
#import <objc/runtime.h>

@implementation NSSegmentedControl (Helper)

-(NSArray<NSString *> *)items{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setItems:(NSArray<NSString *> *)items{
    objc_setAssociatedObject(self, @selector(items), items, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.segmentCount = items.count;
    self.selectedSegment = 0;
    for (NSInteger i = 0; i < items.count; i++) {
        [self setLabel:items[i] forSegment:i];
//        NSLog(@"%@_%@_%@",NSStringFromSelector(_cmd), self, items[i]);
    }
}



@end
