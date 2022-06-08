//
//  HHLabel.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HHLabel.h"

@interface HHLabel ()

 
@end

@implementation HHLabel

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI{
    self.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    self.bordered = false;  ///是否显示边框
    self.editable = false;
    self.drawsBackground = true;
    self.backgroundColor = NSColor.clearColor;

    self.font = [NSFont systemFontOfSize:15];
    self.textColor = NSColor.blackColor;
//    self.alignment = NSTextAlignmentCenter;
    self.maximumNumberOfLines = 1;
    self.usesSingleLineMode = true;
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)event{
    if (self.mouseDownBlock) {
        self.mouseDownBlock(self);
    }
}



@end
