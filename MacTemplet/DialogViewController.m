//
//  DialogViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "DialogViewController.h"

@interface DialogViewController ()

@property (nonatomic, strong) NSButton * btn;
@property (nonatomic, strong) NSButton * btnCancell;

@end

@implementation DialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.greenColor.CGColor;
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.btnCancell];
}

- (void)viewDidLayout{
    [super viewDidLayout];

    CGFloat padding = 8;
    CGFloat gap = 15;
    
    //水平方向控件间隔固定等间隔
    [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.bottom.equalTo(self.view).offset(-30);
        make.size.equalTo(CGSizeMake(80, 50));
    }];
    
    [self.btnCancell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-30);
        make.bottom.equalTo(self.view).offset(-30);
        make.size.equalTo(CGSizeMake(80, 50));
    }];
}

#pragma mark -funtions




#pragma mark -lazy

- (NSButton *)btn{
    if (!_btn) {
        _btn = ({
            NSButton * view = [[NSButton alloc]init];
            view.title = @"确定";
            view.bezelStyle = NSBezelStyleRounded;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSButton * sender = (NSButton *)control;
                DDLog(@"%@", sender.title);
                
                [NSApp.mainWindow endSheet:self.currentWindow returnCode:NSModalResponseOK];
            } forControlEvents:NSEventMaskLeftMouseDown];
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
            view.bezelStyle = NSBezelStyleRounded;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSButton * sender = (NSButton *)control;
                DDLog(@"%@", sender.title);
                
                [NSApp.mainWindow endSheet:self.currentWindow returnCode:NSModalResponseCancel];
            } forControlEvents:NSEventMaskLeftMouseDown];
            view;
        });
    }
    return _btnCancell;
}

@end
