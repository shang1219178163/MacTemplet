//
//  NNView.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNView.h"

@implementation NNView

- (BOOL)isFlipped{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark- set get

-(void)setBackgroundColor:(NSColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    self.layer.backgroundColor = backgroundColor.CGColor;
}

@end
