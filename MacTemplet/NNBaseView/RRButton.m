//
//  RRButton.m
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/21.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import "RRButton.h"

@implementation RRButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:dirtyRect xRadius:self.xRadius yRadius:self.YRadius];
    [self.backgroundColor setFill];
    [path fill];
}

@end
