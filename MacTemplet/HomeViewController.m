//
//  HomeViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()<NSTextViewDelegate, NSTextDelegate>

@property (nonatomic, strong) NSTextView *textView;
@property (nonatomic, strong) NSTextView *textViewTwo;

@property (nonatomic, strong) NSScrollView *scrollView;
@property (nonatomic, strong) NSScrollView *scrollViewTwo;

@property (nonatomic, strong) NNView *bottomView;
@property (nonatomic, strong) NSTextField *textField;
@property (nonatomic, strong) NSTextField *textFieldTwo;
@property (nonatomic, strong) NSButton *btn;

@end

@implementation HomeViewController

- (void)loadView{
    
    NSWindow *window = NSApplication.sharedApplication.mainWindow;
    self.view = [[NNView alloc]initWithFrame:window.frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.title = @"Home";
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.lightGrayColor.CGColor;
    
    self.scrollView.documentView = self.textView;
    [self.view addSubview:self.scrollView];
    
    self.scrollViewTwo.documentView = self.textViewTwo;
    [self.view addSubview:self.scrollViewTwo];
    
    [self.bottomView addSubview:self.textField];
    [self.bottomView addSubview:self.textViewTwo];
    [self.bottomView addSubview:self.btn];
    [self.view addSubview:self.bottomView];


    [self.view getViewLayer];
}

-(void)viewDidLayout{
    [super viewDidLayout];
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    CGFloat padding = 8;
    CGFloat bottom = 50;
    CGFloat gap = 15;

    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.superview);
        make.left.equalTo(self.scrollView.superview);
        make.width.equalTo((width - padding)/2.0);
        make.bottom.equalTo(self.scrollView.superview).offset(-50);
    }];
    
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
    }];

    [self.scrollViewTwo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollViewTwo.superview);
        make.left.equalTo(self.scrollView.right).offset(padding);
        make.right.equalTo(self.scrollViewTwo.superview);
        make.bottom.equalTo(self.scrollView.bottom);
    }];
    
    [self.textViewTwo makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollViewTwo);
    }];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.bottom).offset(padding);
        make.left.right.equalTo(self.bottomView.superview);
        make.bottom.equalTo(self.bottomView.superview);
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.bottomView.superview).offset(gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.right.equalTo(self.bottomView.superview).offset(-gap);
        make.width.equalTo(80);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
}

#pragma mark -funtions

- (void)textDidChange:(NSNotification *)notification{
    
    NSLog(@"%@", notification.object);
}

#pragma mark -funtions

//- (void)hanldeAction:(NSButton *)sender{
//    NSLog(@"%@", sender);
//}

#pragma mark -lazy


-(NSTextView *)textView{
    if (!_textView) {
        _textView = ({
            NSTextView * view = [[NSTextView alloc]init];
            view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            
            view.maxSize = CGSizeMake(FLT_MAX, FLT_MAX);
            [view textContainer].containerSize = NSMakeSize(FLT_MAX, FLT_MAX);
            [view textContainer].widthTracksTextView = true;
            
            view.delegate = self;
            view.backgroundColor = NSColor.yellowColor;
            view;
        });
    }
    return _textView;
}

-(NSTextView *)textViewTwo{
    if (!_textViewTwo) {
        _textViewTwo = ({
            NSTextView * view = [[NSTextView alloc]init];
            view.backgroundColor = NSColor.greenColor;
            view;
        });
    }
    return _textViewTwo;
}

-(NSScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = ({
            NSScrollView * view = [[NSScrollView alloc]init];
            view.hasHorizontalScroller = true;
            view.hasVerticalScroller = true;
            view.backgroundColor = NSColor.randomColor;
            view;
        });
    }
    return _scrollView;
}

-(NSScrollView *)scrollViewTwo{
    if (!_scrollViewTwo) {
        _scrollViewTwo = ({
            NSScrollView * view = [[NSScrollView alloc]init];
            view.hasHorizontalScroller = true;
            view.hasVerticalScroller = true;
            view.backgroundColor = NSColor.randomColor;
            view;
        });
    }
    return _scrollViewTwo;
}

-(NNView *)bottomView{
    if (!_bottomView) {
        _bottomView = ({
            NNView *view = [[NNView alloc]init];
            view.layer.backgroundColor = NSColor.cyanColor.CGColor;
            
            view;
        });
    }
    return _bottomView;
}

-(NSTextField *)textField{
    if (!_textField) {
        _textField = ({
            NSTextField *view = [[NSTextField alloc]init];
//            view.editable = false;  ///是否可编辑
            view.bordered = false;  ///是否显示边框
            view.backgroundColor = NSColor.orangeColor; ///背景色
            view.textColor = NSColor.whiteColor;
            view.alignment = NSTextAlignmentCenter;
            view.maximumNumberOfLines = 1;
            view.placeholderString = @"Class Prefix";
            view.stringValue = @"";
            view;
        });
    }
    return _textField;
}

-(NSTextField *)textFieldTwo{
    if (!_textFieldTwo) {
        _textFieldTwo = ({
            NSTextField *view = [[NSTextField alloc]init];
//            view.editable = false;  ///是否可编辑
            view.bordered = false;  ///是否显示边框
            view.backgroundColor = NSColor.orangeColor; ///背景色
            view.textColor = NSColor.whiteColor;
            view.alignment = NSTextAlignmentCenter;
            view.maximumNumberOfLines = 1;
            view.placeholderString = @"Class Prefix";
            view.stringValue = @"";
            view;
        });
    }
    return _textFieldTwo;
}


-(NSButton *)btn{
    if (!_btn) {
        _btn = ({
            NSButton *view = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 100, 100)];
            view.title = @"保存";
            [view setContentTintColor:NSColor.blueColor];
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSLog(@"%@", control);
                
            } forControlEvents:NSEventMaskLeftMouseDown];
            view;
        });
    }
    return _btn;
}

@end
