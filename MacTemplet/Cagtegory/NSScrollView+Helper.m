//
//  NSScrollView+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSScrollView+Helper.h"

@implementation NSScrollView (Helper)

- (void)scrollToTop{
    if (!self.documentView) {
        return;
    }
    
    if (!self.isFlipped) {
        [self.documentView scrollPoint:CGPointZero];
        
    } else {
//        DDLog(@"%@_%@",@(self.bounds.size.height),@(self.documentView.bounds.size.height));
        CGFloat maxHeight = MAX(self.bounds.size.height, self.documentView.bounds.size.height);
        [self.documentView scrollPoint:CGPointMake(0, maxHeight)];
    }
}

@end
