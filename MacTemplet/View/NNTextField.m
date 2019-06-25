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
    self.cell = [[NNTextFieldCell alloc]initTextCell:@"NNTextFieldCell"];
    self.editable = true;  ///是否可编辑
}

- (void)setIsTextAlignmentVerticalCenter:(BOOL)isTextAlignmentVerticalCenter{
    _isTextAlignmentVerticalCenter = isTextAlignmentVerticalCenter;
    
    ((NNTextFieldCell *)self.cell).isTextAlignmentVerticalCenter = true;
}

@end
