//
//  NNTextViewContoller.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNTextViewContoller.h"
#import "NNHeaderView.h"
#import "NoodleLineNumberView.h"


@interface NNTextViewContoller ()<NSTextViewDelegate>

@property (nonatomic, strong) NSTextView *textView;

@end

@implementation NNTextViewContoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view addSubview:self.textView.enclosingScrollView];

    [NoodleLineNumberView setupLineNumberWithTextView:self.textView];
    [self.view getViewLayer];
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    [self.textView.enclosingScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kX_GAP);
        make.left.equalTo(self.view).offset(kX_GAP);
        make.width.equalTo(400);
        make.bottom.equalTo(self.view).offset(-kX_GAP);
    }];
    
}

#pragma mark -lazy

- (BOOL)textShouldBeginEditing:(NSText *)textObject{
    return true;
}

- (void)textDidEndEditing:(NSNotification *)notification{
    
}

- (void)textDidChange:(NSNotification *)notification{
    NSTextView * view = notification.object;
    
}

#pragma mark -lazy

-(NSTextView *)textView{
    if (!_textView) {
        _textView = ({
            NSTextView * view = [NSTextView create:CGRectZero];
            view.delegate = self;
            view.string = @"";
            view.font = [NSFont systemFontOfSize:NSFont.smallSystemFontSize];
            
            ///
            NSScrollView *scrollView = [[NSScrollView alloc] init];
            scrollView.backgroundColor = NSColor.redColor;
            
            scrollView.drawsBackground = false;//不画背景（背景默认画成白色）
            scrollView.hasHorizontalScroller = false;
            scrollView.hasVerticalScroller = true;
            scrollView.autohidesScrollers = true;//自动隐藏滚动条（滚动的时候出现）
            scrollView.documentView = view;
            
            view;
        });
    }
    return _textView;
}

@end
