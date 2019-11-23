
//
//  BNTabViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "BNTabViewController.h"
#import "NNTextField.h"

#import "OneWindowController.h"
#import "BNDialogWindowController.h"

@interface BNTabViewController ()<NSTabViewDelegate>

@property (nonatomic, strong) NSImageView * imgView;
@property (nonatomic, strong) NNTextField * textField;
@property (nonatomic, strong) NNTextField * textFieldOne;

@property (nonatomic, strong) NSTabView * tabView;

@end

@implementation BNTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.textFieldOne];
    [self.view addSubview:self.tabView];

    NSArray *list = @[@[@"JsonToModelController", @"json转模型", ],
                      @[@"ProppertyLazyController", @"属性Lazy",],
                      @[@"BNTextViewContoller", @"其他",],
                      
                      ];
    [self.tabView addItems:list];
    
    self.textField.stringValue = NSApplication.appName;
    self.textFieldOne.stringValue = NSApplication.appCopyright;
    
    OneWindowController *dialogWindow = [[OneWindowController alloc]init];
    DDLog(@"dialogWindow.window:%@", dialogWindow.window);
    DDLog(@"dialogWindow:%@", dialogWindow);

//    [NSApp beginSheet:dialogWindow.window modalForWindow:NSApp.mainWindow modalDelegate:nil didEndSelector:nil contextInfo:nil];
//    [NSApp runModalForWindow:dialogWindow.window];

    [NSApp.mainWindow beginSheet:dialogWindow.window completionHandler:^(NSModalResponse returnCode) {
        DDLog(@"%@", @(returnCode));
        
    }];
    [NSApp.mainWindow endSheet:dialogWindow.window returnCode:0];
      
    
    [self.view getViewLayer];
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    CGFloat padding = 8;
    CGFloat gap = 15;

    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.superview).offset(30);
        make.left.equalTo(self.imgView.superview).offset(30);
        make.width.height.equalTo(70);
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView).offset(0);
        make.left.equalTo(self.imgView.right).offset(gap);
        make.right.equalTo(self.textField.superview).offset(-30);
        make.height.equalTo(25);
    }];
    
    [self.textFieldOne makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.bottom).offset(padding);
        make.left.equalTo(self.textField).offset(0);
        make.right.equalTo(self.textFieldOne.superview).offset(-30);
        make.height.equalTo(25);
    }];
    
    [self.tabView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.bottom).offset(gap);
        make.left.equalTo(self.tabView.superview).offset(30);
        make.right.equalTo(self.tabView.superview).offset(-30);
        make.bottom.equalTo(self.tabView.superview).offset(-30);
    }];
}


#pragma mark -NSTabViewDelegate

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem{
    NSInteger item = [self.tabView.tabViewItems indexOfObject:tabViewItem];
    DDLog(@"index_%@_%@",@(item), tabViewItem.view);
    
}

#pragma mark -lazy
-(NSImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            NSImageView *view = [NSImageView create:CGRectZero];
            view.image = NSApplication.appIcon;

            view;
        });
    }
    return _imgView;
}

- (NNTextField *)textField{
    if (!_textField) {
        _textField = ({
            NNTextField *view = [NNTextField create:CGRectZero placeholder:@"简单介绍"];
            view.editable = false;
//            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            view;
        });
    }
    return _textField;
}

- (NNTextField *)textFieldOne{
    if (!_textFieldOne) {
        _textFieldOne = ({
            NNTextField *view = [NNTextField create:CGRectZero placeholder:@"简单介绍"];
            view.editable = false;
//            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            view;
        });
    }
    return _textFieldOne;
}

-(NSTabView *)tabView{
    if (!_tabView) {
        _tabView = [NSTabView create:CGRectZero];
        _tabView.delegate = self;
    }
    return _tabView;
}

@end
