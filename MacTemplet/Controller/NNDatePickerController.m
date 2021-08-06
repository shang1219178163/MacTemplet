//
//  NNDatePickerController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNDatePickerController.h"

#import <SwiftExpand-Swift.h>


@interface NNDatePickerController ()

@property (nonatomic, strong) NSButton *btn;
@property (nonatomic, strong) NSButton *btnCancell;
@property (nonatomic, strong) NSDatePicker *datePicker;

@property (nonatomic, strong) NSImageView *imageView;

@end

@implementation NNDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.lightGreen.CGColor;
    
    [self.view addSubview:self.datePicker];
    [self.view addSubview:self.imageView];

    [self.view addSubview:self.btn];
    [self.view addSubview:self.btnCancell];
    
}

- (void)viewDidLayout{
    [super viewDidLayout];

    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.left.equalTo(self.view).offset(20);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.datePicker.right).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.bottom.equalTo(self.datePicker).offset(0);
    }];
    
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view).offset(-20);
        make.size.equalTo(CGSizeMake(80, 35));
    }];
    
    [self.btnCancell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-20);
        make.bottom.equalTo(self.view).offset(-20);
        make.size.equalTo(CGSizeMake(80, 35));
    }];
}

#pragma mark -funtions

- (void)handleActionImgView:(NSImageView *)sender {
    DDLog(@"%@_%@", sender.image, @(sender.image.size));
}

#pragma mark -lazy

-(NSDatePicker *)datePicker{
    if (!_datePicker) {
        _datePicker = ({
            NSDatePicker *view = [[NSDatePicker alloc] init];
            view.datePickerStyle = NSDatePickerStyleClockAndCalendar;
//            view.datePickerStyle = NSDatePickerStyleTextFieldAndStepper;
            
            view.layer.backgroundColor = NSColor.whiteColor.CGColor;
            
            // 设置日期选择控件的类型为“时钟和日历”。其他类型有如，NSTextField文本框
            view.dateValue = NSDate.date;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSDatePicker *sender = (NSDatePicker *)control;
                NSString *dateStr = [NSDateFormatter stringFromDate:sender.dateValue fmt:kFormatDate];
                DDLog(@"%@", dateStr);
                
            }];
            
            view;
        });
    }
    return _datePicker;
}

- (NSImageView *)imageView{
    if (!_imageView) {
        _imageView = ({
            NSImageView *view = [[NSImageView alloc]initWithFrame:CGRectZero];
            view.wantsLayer = true;
            view.imageAlignment = NSImageAlignCenter; //圖片內容對於控件的位置
            view.imageFrameStyle = NSImageFrameNone; //圖片邊框的樣式
            view.editable = true;
            view.allowsCutCopyPaste = true;

            view.imageScaling = NSImageScaleAxesIndependently;
            view.animates = true;
            view.canDrawSubviewsIntoLayer = true;
            view.image = [NSImage imageNamed:@"timg.gif"];
            
            ///屏蔽拖动
//            [view unregisterDraggedTypes];

            view.target = self;
            view.action = @selector(handleActionImgView:);

            view;
        });
    }
    return _imageView;
}


- (NSButton *)btn{
    if (!_btn) {
        _btn = ({
            NSButton * view = [[NSButton alloc]init];
            view.title = @"确定";
            view.bezelStyle = NSBezelStyleRegularSquare;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSButton *sender = (NSButton *)control;
                DDLog(@"%@", sender.title);

                [NSApp.keyWindow endSheet:self.view.window returnCode:NSModalResponseOK];
            }];
            view;
        });
    }
    return _btn;
}

- (NSButton *)btnCancell{
    if (!_btnCancell) {
        _btnCancell = ({
            NSButton * view = [[NSButton alloc]init];
            view.title = @"取消";
            view.bezelStyle = NSBezelStyleRegularSquare;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSButton *sender = (NSButton *)control;
                DDLog(@"%@", sender.title);
                
                [NSApp.keyWindow endSheet:self.view.window returnCode:NSModalResponseCancel];
            }];
            view;
        });
    }
    return _btnCancell;
}


@end
