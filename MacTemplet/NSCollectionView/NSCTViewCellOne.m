//
//  NSCTViewCellOne.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSCTViewCellOne.h"

#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#import "Masonry.h"

#import <SwiftExpand-Swift.h>

@interface NSCTViewCellOne ()


@end

@implementation NSCTViewCellOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.label];
    
    self.imgView.layer.backgroundColor = NSColor.greenColor.CGColor;
    self.label.layer.backgroundColor = NSColor.yellowColor.CGColor;

}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    if (self.view.bounds.size.height <= 0) {
        return;
    }
    
    CGFloat gap = 10;
    CGFloat padding = 8;

    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.superview).offset(gap);
        make.right.equalTo(self.imgView.superview).offset(30);
        make.left.equalTo(self.imgView.superview).offset(-30);
        make.height.equalTo(30).priority(900);
    }];
    
    [self.label makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imgView.bottom).offset(padding);
        make.right.equalTo(self.label.superview).offset(gap);
        make.left.equalTo(self.label.superview).offset(-gap);
        make.bottom.equalTo(self.label.superview).offset(-gap);
    }];
}

- (void)viewWillAppear {
    if(!self.representedObject){
        return;
    }
//    self.imgView.image = [self.representedObject objectForKey:@"image"];
//    self.label.stringValue = [self.representedObject objectForKey:@"title"];
//    self.imgView.image = [NSImage imageNamed:self.representedObject];
//    self.label.stringValue = self.representedObject;
}


// 重写选中方法
- (void)setSelected:(BOOL)selected{
//    [self.view setIsSelected:selected];
    [super setSelected:selected];
}

#pragma mark -lazy
-(NSImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            NSImageView *view = [NSImageView create:CGRectZero];
            view.image = NSApplication.appIcon;
            view.imageScaling = NSImageScaleProportionallyDown;
            view;
        });
    }
    return _imgView;
}

- (NNTextField *)label{
    if (!_label) {
        _label = ({
            NNTextField *view = [NNTextField create:CGRectZero placeholder:@"简单介绍"];
            view.editable = false;
            view.font = [NSFont systemFontOfSize:12];
            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            
            view;
        });
    }
    return _label;
}

//- (NNTextField *)textField{
//    if (!_textField) {
//        _textField = ({
//            NNTextField *view = [NNTextField create:CGRectZero text:@"" placeholder:@"简单介绍"];
//            view.editable = false;
//            //            view.alignment = NSTextAlignmentCenter;
//            view.isTextAlignmentVerticalCenter = true;
//            view;
//        });
//    }
//    return _textField;
//}

@end
