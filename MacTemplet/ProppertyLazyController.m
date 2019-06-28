//
//  ProppertyLazyController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "ProppertyLazyController.h"
#import "NNHeaderView.h"
#import "NoodleLineNumberView.h"
#import "BNPropertyInfoModel.h"

@interface ProppertyLazyController ()<NSTextViewDelegate>

@property (nonatomic, strong) NNTextView *textView;
@property (nonatomic, strong) NNTextView *textViewOne;
@property (nonatomic, strong) NNView *bottomView;

@property (nonatomic, strong) NSArray *btnItems;

@end

@implementation ProppertyLazyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.btnItems = @[@"属性Lazy", @"属性Lazy",];

    [self.view addSubview:self.textView.enclosingScrollView];
    [self.view addSubview:self.textViewOne.enclosingScrollView];
    [self.view addSubview:self.bottomView];

    [NoodleLineNumberView setupLineNumberWithTextView:self.textView];
    
    self.textView.string = @"@property (nonatomic, strong) NNTextView *textView;\n@property (nonatomic, strong) NNView *bottomView;\n@property (nonatomic, strong) NSMutableArray *list;\n@property (nonatomic, strong) NSMutableDictionary *dic;\n@property (nonatomic, strong) NSMutableString *mstr;";
    
    [self.textView resignFirstResponder];

//    [self.view getViewLayer];
}

- (void)viewDidLayout{
    [super viewDidLayout];

    NSArray *list = @[self.textView.enclosingScrollView, self.textViewOne.enclosingScrollView];
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:10 tailSpacing:10];
//    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:150 leadSpacing:10 tailSpacing:10];
    [list makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view.bottom).offset(-50);
    }];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.enclosingScrollView.bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    NSArray * btns = self.bottomView.subviews;
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:10 tailSpacing:10];
    [btns makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(kY_GAP);
        make.bottom.equalTo(self.bottomView).offset(-kY_GAP);
    }];
    
}

#pragma mark -lazy

- (BOOL)textShouldBeginEditing:(NSText *)textObject{
    return true;
}

- (void)textDidEndEditing:(NSNotification *)notification{
    NSTextView * textView = notification.object;
    
    DDLog(@"%@",textView.string);
    self.textViewOne.string = [self createResult:textView.string];

}

- (void)textDidChange:(NSNotification *)notification{
//    NSTextView * view = notification.object;
    
}

#pragma mark -funtions

- (NSString *)createResult:(NSString *)string{
    NSArray * list = [BNPropertyInfoModel modelsWithString:string];
    NSMutableString *mStr = [NSMutableString string];
    [list enumerateObjectsUsingBlock:^(BNPropertyInfoModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * desc = model.lazyDes;
        [mStr appendFormat:@"%@\n", desc];
        
    }];
    return mStr;
}

#pragma mark -lazy

-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
            view.delegate = self;
            view.string = @"";
            view.font = [NSFont systemFontOfSize:12];
            
            view;
        });
    }
    return _textView;
}

-(NNTextView *)textViewOne{
    if (!_textViewOne) {
        _textViewOne = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
//            view.delegate = self;
            view.string = @"";
            view.font = [NSFont systemFontOfSize:12];
            
            view;
        });
    }
    return _textViewOne;
}

- (NNView *)bottomView{
    if (!_bottomView) {
        _bottomView = ({
            NNView * view = [[NNView alloc]init];
            
            for (NSInteger i = 0; i < self.btnItems.count; i++) {
                NNButton *btn = [NNButton createBtnRect:CGRectZero];
//                btn.titleColor = NSColor.redColor;
//                btn.backgroundColor = NSColor.greenColor;

                btn.title = self.btnItems[i];
                [btn addActionHandler:^(NSControl * _Nonnull control) {
                    [NSApp.mainWindow makeFirstResponder:nil];
                    
                    self.textViewOne.string = [self createResult:self.textView.string];

                } forControlEvents:NSEventMaskLeftMouseDown];
                [view addSubview:btn];
            }
            view;
        });
    }
    return _bottomView;
}


@end
