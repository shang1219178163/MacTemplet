
//
//  NNButton.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNButton.h"

@implementation NNButton

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
    NSColor * backgroundColor = self.backgroundColor ? : NSColor.whiteColor;
    [backgroundColor set];
    NSRectFill(self.bounds);
    
    if (self.title) {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
        paraStyle.alignment = NSTextAlignmentCenter;

        NSDictionary *attrDic = @{
                                  NSFontAttributeName: [NSFont fontWithName:@"PingFangSC-Light" size:14],
                                  NSForegroundColorAttributeName: self.titleColor ? : NSColor.blackColor,
                                  NSParagraphStyleAttributeName: paraStyle,
                                  };
        
        NSAttributedString * title = [[NSAttributedString alloc]initWithString:self.title attributes:attrDic];
//        [title drawInRect:NSMakeRect(0 , 4, self.frame.size.width, self.frame.size.height)];
        [title drawInRect:NSMakeRect(0 , (self.frame.size.height - 30)*0.5, self.frame.size.width, 30)];

    }
    
}

@end
