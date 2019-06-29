//
//  AuthorInfoController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "AuthorInfoController.h"
#import "NNHeaderView.h"

@interface AuthorInfoController ()

@property (nonatomic, strong) NSImageView * imgView;
@property (nonatomic, strong) NNTextField * textField;
@property (nonatomic, strong) NSTextField * textFieldOne;
@property (nonatomic, strong) NNTextView * textView;

@end

@implementation AuthorInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view addSubview:self.imgView];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.textFieldOne];
    [self.view addSubview:self.textView];
   

    self.textFieldOne.hidden = true;
    self.textView.hidden = true;

    NSDictionary *dic = @{
                          @"github/shang1219178163": @"https://github.com/shang1219178163",
                          };
    
    self.textField.stringValue = [NSString stringWithFormat:@"%@\n%@\n%@", NSApplication.appName, NSApplication.appCopyright, @"github/shang1219178163"];
    [self.textField setHyperlinkDic:dic];
    
    self.textFieldOne.stringValue = [NSString stringWithFormat:@"%@\n%@\n%@", NSApplication.appName, NSApplication.appCopyright, @"github/shang1219178163"];
    [self.textFieldOne setHyperlinkDic:dic];
    
    self.textView.string = [NSString stringWithFormat:@"%@\n%@\n%@", NSApplication.appName, NSApplication.appCopyright, @"github/shang1219178163"];
    [self.textView setHyperlinkDic:dic];
//    [self.view getViewLayer];
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    [self.imgView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(30);
        make.width.height.equalTo(70);
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView).offset(0);
        make.left.equalTo(self.imgView.right).offset(kX_GAP);
        make.right.equalTo(self.view).offset(-30);
        make.height.equalTo(80);
    }];
    
    [self.textFieldOne makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.bottom).offset(kPadding);
        make.left.equalTo(self.textField).offset(0);
        make.right.equalTo(self.view).offset(-30);
        make.height.equalTo(80);
    }];
    
    [self.textView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textFieldOne.bottom).offset(kPadding);
        make.left.equalTo(self.textField).offset(0);
        make.right.equalTo(self.view).offset(-30);
        make.height.equalTo(80);
    }];
}


#pragma mark -lazy
-(NSImageView *)imgView{
    if (!_imgView) {
        _imgView = ({
            NSImageView *view = [NSImageView createImgViewRect:CGRectZero image:NSApplication.appIcon];
            view.editable = false;
            view;
        });
    }
    return _imgView;
}

- (NNTextField *)textField{
    if (!_textField) {
        _textField = ({
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"简单介绍"];
            
            view.cell.scrollable = true;
            
            view.font = [NSFont fontWithName:@"PingFangSC-Light" size:14];
            view.cell.wraps = true;
            
            view.editable = false;
            view.selectable = true;
            view.allowsEditingTextAttributes = true;
            if (@available(macOS 10.12.2, *)) {
                view.automaticTextCompletionEnabled = true;
            } else {
                // Fallback on earlier versions
            }
            //            view.alignment = NSTextAlignmentCenter;
            //            view.isTextAlignmentVerticalCenter = true;
            view;
        });
    }
    return _textField;
}

- (NSTextField *)textFieldOne{
    if (!_textFieldOne) {
        _textFieldOne = ({
            NSTextField *view = [[NSTextField alloc]init];
            
            view.cell.scrollable = true;
            
            view.font = [NSFont fontWithName:@"PingFangSC-Light" size:14];
            view.cell.wraps = true;
            
            view.editable = false;
            view.selectable = true;
            view.allowsEditingTextAttributes = true;
            if (@available(macOS 10.12.2, *)) {
                view.automaticTextCompletionEnabled = true;
            } else {
                // Fallback on earlier versions
            }
            view;
        });
    }
    return _textFieldOne;
}

-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
//            view.delegate = self;
            view.string = @"";
            view.font = [NSFont fontWithName:@"PingFangSC-Light" size:14];
            
            
            view.editable = false;
            view.selectable = true;
            if (@available(macOS 10.12.2, *)) {
                view.automaticTextCompletionEnabled = true;
            } else {
                // Fallback on earlier versions
            }
            view;
        });
    }
    return _textView;
}

@end

