//
//  NNTextField.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNTextField.h"
#import "NNTextFieldCell.h"

@implementation NNTextField

- (instancetype)init{
    self = [super init];
    if (self) {
        self.cell = [[NNTextFieldCell alloc]initTextCell:@"NNTextFieldCell"];
    }
    return self;
}

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.cell = [[NNTextFieldCell alloc]initTextCell:@"NNTextFieldCell"];
    }
    return self;
}

- (void)setIsTextAlignmentVerticalCenter:(BOOL)isTextAlignmentVerticalCenter{
    _isTextAlignmentVerticalCenter = isTextAlignmentVerticalCenter;
    
    ((NNTextFieldCell *)self.cell).isTextAlignmentVerticalCenter = true;
}

@end
