//
//  NSTableRowViewTen.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/25.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTableCellViewTen.h"

@interface NSTableCellViewTen ()


@end

@implementation NSTableCellViewTen

- (instancetype)initWithFrame:(NSRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.checkBox];
        [self addSubview:self.textLabel];
        [self addSubview:self.textView.enclosingScrollView];

//        [self getViewLayer];
    }
    return self;
}

- (void)layout{
    [super layout];

    CGSize checkBoxSize = [self.checkBox sizeThatFits:CGSizeMake(100, 30)];
    [self.checkBox makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kX_GAP);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(checkBoxSize.width);
        make.height.equalTo(checkBoxSize.height);
    }];
    
    CGSize textLabelSize = [self.textLabel sizeThatFits:CGSizeMake(180, 30)];
    [self.textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.checkBox);
        make.right.equalTo(self).offset(-kX_GAP);
        make.width.equalTo(180);
        make.height.lessThanOrEqualTo(textLabelSize.height);
    }];
    
    [self.textView.enclosingScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.checkBox.bottom).offset(kPadding);
        make.left.equalTo(self.checkBox);
        make.right.equalTo(self.textLabel);
        make.bottom.equalTo(self);
    }];
}

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark -lazy

- (NSButton *)checkBox{
    if (!_checkBox) {
        _checkBox = ({
            NSButton * view = [NSButton checkboxWithTitle:@"构造函数" target:nil action:nil];
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSButton *sender = (NSButton *)control;
                DDLog(@"state_%@", @(sender.state));
                
            }];
            view;
        });
    }
    return _checkBox;
}

-(NNTextLabel *)textLabel{
    if (!_textLabel) {
        _textLabel = ({
            NNTextLabel * view = [[NNTextLabel alloc]initWithFrame:CGRectZero];
            view.font = [NSFont systemFontOfSize:13];
            view.alignment = NSTextAlignmentRight;
            view.bordered = false;
            view.backgroundColor = [NSColor.clearColor colorWithAlphaComponent:0];

            view.stringValue = self.className;
            view;
        });
    }
    return _textLabel;
}

-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
//            view.delegate = self;
            view.font = [NSFont systemFontOfSize:12];
            view.layer.borderWidth = 1;
            view.layer.borderColor = NSColor.lightGrayColor.CGColor;
            
            view;
        });
    }
    return _textView;
}


@end
