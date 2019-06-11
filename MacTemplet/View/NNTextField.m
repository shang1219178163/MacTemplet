//
//  NNTextField.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNTextField.h"

@implementation NNTextField

- (void)drawRect:(NSRect)dirtyRect {
    //    [super drawRect:dirtyRect];
    
    // Drawing code here.
    CGRect rect = CGRectMake(0, (dirtyRect.size.height - 22)/2.0, dirtyRect.size.width, 22);
    return [super drawRect:rect];
}

@end
