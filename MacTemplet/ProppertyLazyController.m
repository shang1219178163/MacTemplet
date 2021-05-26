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

#import <SwiftExpand-Swift.h>

@interface ProppertyLazyController ()<NSTextViewDelegate>

@property (nonatomic, strong) HHLabel *textLabel;
@property (nonatomic, strong) NNTextView *textView;
@property (nonatomic, strong) NNTextView *textViewOne;
@property (nonatomic, strong) NNView *bottomView;

@property (nonatomic, strong) NSArray *btnItems;

@end

@implementation ProppertyLazyController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do view setup here.
    self.textLabel.stringValue = @"此处文本框显示的效果和 XCode(Version 11.1 (11A1027))显示效果有差异, 以 XCode 实际效果为准";
    self.btnItems = @[@"属性Lazy", @"Copy",];

    [self.view addSubview:self.textView.enclosingScrollView];
    [self.view addSubview:self.textViewOne.enclosingScrollView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.textLabel];

    [NoodleLineNumberView setupLineNumberWithTextView:self.textView];
    
    self.textView.string = @"\n\
@property (nonatomic, strong) UITextView *textView;\n\
@property (nonatomic, strong) UIView *bottomView;\n\
@property (nonatomic, strong) NSMutableArray *list;\n\
@property (nonatomic, strong) NSMutableDictionary *dic;\n\
@property (nonatomic, strong) NSMutableString *mstr;\n\
@property (nonatomic, strong) UIImageView *imgView;\n\
@property (nonatomic, strong) UIButton *btn;\n\
@property (class, nonatomic, copy, readonly) NSDictionary<NSString *, NSString *> *subject_typeDic;"
    ;

    [self.textView resignFirstResponder];

//    [self.view getViewLayer];
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    NSArray *list = @[self.textView.enclosingScrollView, self.textViewOne.enclosingScrollView];
    [list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15 leadSpacing:0 tailSpacing:0];
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
    
    NSArray *btns = self.bottomView.subviews;
    [btns mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:100 leadSpacing:10 tailSpacing:10];
    [btns makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).offset(kY_GAP);
        make.bottom.equalTo(self.bottomView).offset(-kY_GAP);
    }];
    
    [self.textLabel sizeToFit];
    self.textLabel.center = self.bottomView.center;
}

#pragma mark -NSText

- (BOOL)textShouldBeginEditing:(NSText *)textObject{
    return true;
}

- (void)textDidEndEditing:(NSNotification *)notification{
//    NSTextView * textView = notification.object;
    
//    DDLog(@"%@",textView.string);
    [self showConvertResult];
}

- (void)textDidChange:(NSNotification *)notification{
//    NSTextView * textView = notification.object;
    [self showConvertResult];
}

#pragma mark -funtions

- (NSString *)createResult:(NSString *)string{
    NSArray *list = [NNPropertyModel modelsWith:string];
    NSMutableString *mStr = [NSMutableString string];
    [list enumerateObjectsUsingBlock:^(NNPropertyModel * model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *desc = model.lazyDes;
        [mStr appendFormat:@"%@\n", desc];
    }];
    return mStr;
}

- (void)showConvertResult {
    if (![self.textView.string containsString:@"*"]) {
        [NSAlert show:@"提示" message:@"❌lazy属性必须包含*" btnTitles:nil handler:nil];
        return;
    }
    [NSApp.mainWindow makeFirstResponder:nil];
    self.textViewOne.string = [self createResult:self.textView.string];
//    [NSPasteboard.generalPasteboard clearContents];
//    [NSPasteboard.generalPasteboard setString:self.textViewOne.string forType:NSPasteboardTypeString];
}

- (IBAction)showAlert:(id)sender {
//    NSAlert *alert = NSAlert createAlertTitle:@"提示" msg:@"Sample Test" btnTitles:@[ktit]
//    NSAlert = [NSAlert alertWithMessageText:@"Sample Test" defaultButton:@"OK" alternateButton:@"DO Nothing" otherButton:@"CANCEL" informativeTextWithFormat:@"TEST",nil];
//    [self.myAlert beginSheetModalForWindow:[self window]
//                         modalDelegate:self
//                        didEndSelector:@selector(errorAlertDidEnd:returnCode:contextInfo:)
//                           contextInfo:nil];
//
//    NSArray *buttonArray = [self.myAlert buttons];
//    NSLog(@"Button Arrays %@",buttonArray);
//
//    //Close by itself without a mouse click by the user
//    //Assuming the Default Button as the Second one "Do Nothing
//    NSButton *myBtn = buttonArray[2];
//    [myBtn performClick:self.myAlert];
}

#pragma mark -lazy

-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView *view = [NNTextView create:CGRectZero];
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
            NNTextView *view = [NNTextView create:CGRectZero];
//            view.delegate = self;
            view.string = @"";
            view.font = [NSFont systemFontOfSize:12];
            
            view;
        });
    }
    return _textViewOne;
}

-(HHLabel *)textLabel{
    if (!_textLabel) {
        _textLabel = ({
            HHLabel *view = [[HHLabel alloc]initWithFrame:CGRectZero];
            view.bordered = false;  ///是否显示边框
            view.font = [NSFont systemFontOfSize:13];
            view.textColor = NSColor.systemGreenColor;
//            view.textColor = NSColor.lightBlue;
            view.alignment = NSTextAlignmentCenter;

            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.backgroundColor = NSColor.clearColor;
//            view.stringValue = @""
            view.mouseDownBlock = ^(HHLabel * _Nonnull sender) {
  
            };
            view;
        });
    }
    return _textLabel;
}

- (NNView *)bottomView{
    if (!_bottomView) {
        _bottomView = ({
            NNView *view = [[NNView alloc]init];
            
            for (NSInteger i = 0; i < self.btnItems.count; i++) {
                NSButton *btn = [NSButton new];
                btn.bezelStyle = NSBezelStyleRegularSquare;
          
                btn.title = self.btnItems[i];
                btn.tag = i;
                [btn addTarget:self action:@selector(p_handleAction:) on: NSEventMaskOtherMouseUp];
                [view addSubview:btn];
            }
            view;
        });
    }
    return _bottomView;
}

- (void)p_handleAction:(NNButton *)sender {
    switch (sender.tag) {
        case 0:
            [self showConvertResult];

            break;
        case 1:
        {
            [NSPasteboard.generalPasteboard clearContents];
            [NSPasteboard.generalPasteboard setString:self.textViewOne.string forType:NSPasteboardTypeString];
            
//            NSAlert * alert = ({
//                NSAlert * alert = [[NSAlert alloc]init];
//                alert.messageText = @"已复制到剪切板";
//                
//            });
//            [alert beginSheetModalHandler:^(NSModalResponse returnCode) {
//                
//            }];
//            [alert runModal];

        }
            break;
        default:
            break;
    }
}

@end
