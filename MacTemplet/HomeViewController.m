//
//  HomeViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HomeViewController.h"
#import <Photos/Photos.h>
#import "NNView.h"
#import "NNTextView.h"
#import "NNTextField.h"
#import "NNTableView.h"
#import "NoodleLineNumberView.h"

#import "ESJsonFormatManager.h"
#import "ESJsonFormat.h"
#import "ESClassInfo.h"
#import "ESJsonFormatSetting.h"
#import "ESPair.h"
#import "FileManager.h"

#import "DataModel.h"

#import <YYModel/YYModel.h>
#import "NNLanguageModel.h"

@interface HomeViewController ()<NSTextViewDelegate, NSTextFieldDelegate, NSTextDelegate>

@property (nonatomic, strong) NNTextView *textView;
@property (nonatomic, strong) NNTextView *hTextView;
@property (nonatomic, strong) NNTextView *mTextView;

@property (nonatomic, strong) NNView *bottomView;
@property (nonatomic, strong) NNTextField *textField;
@property (nonatomic, strong) NNTextField *textFieldTwo;
@property (nonatomic, strong) NNTextField *textFieldThree;

//@property (nonatomic, strong) NSSegmentedControl *segmentCtl;

@property (nonatomic, strong) NSPopUpButton *popBtn;
@property (nonatomic, strong) NSButton *btn;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSString *hFilename;
@property (nonatomic, strong) NSString *mFilename;

//@property (nonatomic, strong) NNTableView *tableView;
@property (nonatomic, strong) NSDictionary * langsDic;
@property (nonatomic, strong) NNLanguageModel * langModel;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.title = @"Home";
    
    [self.view addSubview:self.textView.enclosingScrollView];
    [self.view addSubview:self.hTextView.enclosingScrollView];
    [self.view addSubview:self.mTextView.enclosingScrollView];

    [self.bottomView addSubview:self.textField];
    [self.bottomView addSubview:self.textFieldTwo];
    [self.bottomView addSubview:self.textFieldThree];

    [self.bottomView addSubview:self.btn];
    [self.bottomView addSubview:self.popBtn];
//    [self.bottomView addSubview:self.segmentCtl];
    [self.view addSubview:self.bottomView];

//    [self.view getViewLayer];
    
//    self.segmentCtl.selectedSegment = 1;
    [self readFile];
    [self updateLanguages];

    NSApplication.windowDefault.minSize = CGSizeMake(kScreenWidth*0.5, kScreenHeight*0.5);
    
}

-(void)viewDidAppear{
    [super viewDidAppear];
    
    NSString * folderPath = @"/Users/shang/Downloads";
    [NSUserDefaults.standardUserDefaults setObject:folderPath forKey:kFolderPath];

    [NSUserDefaults.standardUserDefaults setObject:@"NN" forKey:kClassPrefix];
    [NSUserDefaults.standardUserDefaults setObject:@"NSObject" forKey:kSuperClass];
    [NSUserDefaults.standardUserDefaults setObject:@"NNRootClass" forKey:kRootClass];
    
    [NSUserDefaults.standardUserDefaults setBool:false forKey:kIsSwift];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    self.textField.stringValue = @"NN";
    self.textFieldTwo.stringValue = @"NNRootClass";
    self.textFieldThree.stringValue = @"NSObject";
}

-(void)viewDidLayout{
    [super viewDidLayout];
    
    CGFloat padding = 8;
    CGFloat gap = 15;
    
    self.list = @[self.textView.enclosingScrollView, self.hTextView.enclosingScrollView, self.mTextView.enclosingScrollView];
    //水平方向控件间隔固定等间隔
    [self.list mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:gap leadSpacing:0 tailSpacing:0];
    [self.list mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.enclosingScrollView.superview);
        make.bottom.equalTo(self.textView.enclosingScrollView.superview).offset(-55);
    }];
        
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.enclosingScrollView.bottom).offset(padding);
        make.left.right.equalTo(self.bottomView.superview);
        make.bottom.equalTo(self.bottomView.superview);
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.bottomView.superview).offset(gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.textFieldTwo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.textField.right).offset(gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.textFieldThree makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.textFieldTwo.right).offset(gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.right.equalTo(self.bottomView.superview).offset(-gap);
        make.width.equalTo(80);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.popBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.right.equalTo(self.btn.left).offset(-gap);
        make.width.equalTo(160);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
//    [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.textField.superview).offset(padding);
//        make.right.equalTo(self.popBtn.left).offset(-gap);
//        make.width.equalTo(150);
//        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
//    }];
    
}

#pragma mark -NSTextDelegate

- (void)textDidChange:(NSNotification *)notification{
    NSTextView * view = notification.object;
    NSLog(@"length:%@", @(view.string.length));
    NSLog(@"containerSize:%@", @(view.textContainer.containerSize));
//    [view scrollRangeToVisible: NSMakeRange(FLT_MAX, FLT_MAX)];
}

- (void)textDidEndEditing:(NSNotification *)notification{
    
}


#pragma mark -NSControlTextEditingDelegate

- (void)controlTextDidChange:(NSNotification *)obj {
    // You can get the NSTextField, which is calling the method, through the userInfo dictionary.
    NSTextField *textField = (NSTextField *)obj.object;
    DDLog(@"%@",textField.stringValue);
 
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
    NSTextField *textField = (NSTextField *)obj.object;
//    DDLog(@"%@",textField.stringValue);
    
    NSDictionary *dic = @{
                         @(100): kClassPrefix,
                         @(101): kSuperClass,
                         @(102): kRootClass,

                         };
    NSString * defaultsKey = dic[@(textField.tag)];
    [NSUserDefaults.standardUserDefaults setObject:textField.stringValue forKey:defaultsKey];
    [NSUserDefaults.standardUserDefaults synchronize];
//    DDLog(@"%@_%@_%@",@(textField.tag), defaultsKey, textField.stringValue);

}

//- (void)hanldeAction:(NSButton *)sender{
//    NSLog(@"%@", sender);
//}

#pragma mark -funtions

- (void)readFile{
    NSString *path = [NSBundle.mainBundle pathForResource:@"appinfo" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    id obj = content.objValue;
//    DDLog(@"%@", obj);
    
    self.textView.string = [(NSDictionary *)obj jsonString];
}

- (void)clearFileOutputPath {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:kFolderPath];
    [NSUserDefaults.standardUserDefaults synchronize];
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"\nClear Success.";
    [alert runModal];
    
}

- (void)hanldeJson{
    self.hTextView.string = @"";
    self.mTextView.string = @"";
    
    id result = self.textView.string.objValue;
    if (!result) {
        NSError *error = [NSError errorWithDomain:@"Error：Json is invalid" code:3840 userInfo:nil];
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
        NSLog(@"Error：Json is invalid");
        
        return;
    }
    
    ESClassInfo *classInfo = [ESClassInfo dealClassNameWithJsonResult:result handler:^(NSString *hFilename, NSString *mFilename) {
        self.hFilename = hFilename;
        self.mFilename = mFilename;
    }];
    classInfo.langModel = self.langModel;
    [self outputResult:classInfo];
    
}

#pragma mark - Change ESJsonFormat
-(void)outputResult:(ESClassInfo*)classInfo{
    
    if (ESJsonFormatSetting.defaultSetting.outputToFiles) {
        //选择保存路径
        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];
        if ([panel runModal] == NSModalResponseOK) {
            NSString *folderPath = [panel.URLs.firstObject relativePath];
            [classInfo createFileWithFolderPath:folderPath];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
        
    } else {
        if (!self.hTextView) return;
        if (![NSUserDefaults.standardUserDefaults boolForKey:kIsSwift]) {
            self.hTextView.string = [classInfo classDescWithFirstFile:true];
            self.mTextView.string = [classInfo classDescWithFirstFile:false];

        } else {
            self.hTextView.string = [classInfo classDescWithFirstFile:true];

        }
//        [self creatFile];
    }
}

- (void)creatFile{
    NSString *folderPath = [NSUserDefaults.standardUserDefaults valueForKey:kFolderPath];
    if (folderPath) {
        [FileManager.sharedInstance createFileWithFolderPath:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:self.hTextView.string mContent:self.mTextView.string];
        [NSWorkspace.sharedWorkspace openFile:folderPath];
        
    } else {
        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];
        if (panel.runModal == NSModalResponseOK) {
            folderPath = [panel.URLs.firstObject relativePath];
            [NSUserDefaults.standardUserDefaults setValue:folderPath forKey:kFolderPath];
            NSLog(@"%@",folderPath);
            [FileManager.sharedInstance createFileWithFolderPath:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:self.hTextView.string mContent:self.mTextView.string];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
    }
}

- (void)updateLanguages{
    NSArray * items = [self.langsDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self.popBtn removeAllItems];
    [self.popBtn addItemsWithTitles:items];
    
}

#pragma mark -lazy

-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
            view.delegate = self;
            view.string = @"NSScrollView上无法滚动的NSTextView";
            view.font = [NSFont systemFontOfSize:12];
            
//            NoodleLineNumberView *lineNumberView = [[NoodleLineNumberView alloc]initWithScrollView:view.enclosingScrollView];
//            view.enclosingScrollView.hasHorizontalRuler = false;
//            view.enclosingScrollView.hasVerticalRuler = true;
//            view.enclosingScrollView.verticalRulerView = lineNumberView;
//            view.enclosingScrollView.rulersVisible = true;
//            view.font = [NSFont systemFontOfSize:NSFont.smallSystemFontSize];
            
            view;
        });
    }
    return _textView;
}

-(NNTextView *)hTextView{
    if (!_hTextView) {
        _hTextView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
            view.editable = false;
            view.delegate = self;
            view.font = [NSFont systemFontOfSize:14];

            view;
        });
    }
    return _hTextView;
}

-(NNTextView *)mTextView{
    if (!_mTextView) {
        _mTextView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
            view.editable = false;
            view.delegate = self;
            view.font = [NSFont systemFontOfSize:14];

            view;
        });
    }
    return _mTextView;
}

-(NNView *)bottomView{
    if (!_bottomView) {
        _bottomView = ({
            NNView *view = [[NNView alloc]init];
            view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            
            view;
        });
    }
    return _bottomView;
}

-(NNTextField *)textField{
    if (!_textField) {
        _textField = ({
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Class Prefix"];
            view.bordered = true;  ///是否显示边框
            
            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            
            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.tag = 100;
            view.delegate = self;
            
            view;
        });
    }
    return _textField;
}

-(NNTextField *)textFieldTwo{
    if (!_textFieldTwo) {
        _textFieldTwo = ({
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Supper Class name"];
            view.bordered = true;  ///是否显示边框

            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;

            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.tag = 101;
            view.delegate = self;
            
            view;
        });
    }
    return _textFieldTwo;
}

-(NNTextField *)textFieldThree{
    if (!_textFieldThree) {
        _textFieldThree = ({
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Root Class name"];
            view.bordered = true;  ///是否显示边框
            
            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            
            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.tag = 102;
            view.delegate = self;
            
            view;
        });
    }
    return _textFieldThree;
}

//-(NSSegmentedControl *)segmentCtl{
//    if (!_segmentCtl) {
//        _segmentCtl = ({
//            NSArray *items = @[@"OC", @"Swift",];
//            NSSegmentedControl * view = [[NSSegmentedControl alloc] init];
//            view.items = items;
//            [view addActionHandler:^(NSControl * _Nonnull control) {
//                [NSApp.mainWindow makeFirstResponder:nil];
//
//                NSSegmentedControl *sender = (NSSegmentedControl *)control;
//                NSLog(@"%@", @(sender.selectedSegment));
//
//                BOOL isSwift = (sender.selectedSegment == 0) ? false : true;
//                [NSUserDefaults.standardUserDefaults setBool:isSwift forKey:kIsSwift];
//                [NSUserDefaults.standardUserDefaults synchronize];
//
//                [self hanldeJson];
////                [self clearFileOutputPath];
//
//            }];
//            view;
//        });
//    }
//    return _segmentCtl;
//}

- (NSPopUpButton *)popBtn{
    if (!_popBtn) {
        _popBtn = ({
            NSPopUpButton *view = [[NSPopUpButton alloc] initWithFrame:CGRectZero pullsDown:false];
            view.autoenablesItems = true;
            
            NSArray *list = @[@"北京", @"上海", @"广州", @"深圳"];
            [view addItemsWithTitles:list];
            [view addActionHandler:^(NSControl * _Nonnull control) {
                [NSApp.mainWindow makeFirstResponder:nil];

                NSPopUpButton *sender = (NSPopUpButton *)control;
                NSLog(@"%@", sender.titleOfSelectedItem);
                self.langModel = self.langsDic[sender.titleOfSelectedItem];
                DDLog(@"%@", self.langModel);

                [NSUserDefaults.standardUserDefaults setObject:sender.titleOfSelectedItem forKey:kDisplayName];
                bool isSwift = [sender.titleOfSelectedItem containsString:@"Swift"] || [sender.titleOfSelectedItem containsString:@"swift"];
                [NSUserDefaults.standardUserDefaults setBool:isSwift forKey:kIsSwift];
                [NSUserDefaults.standardUserDefaults setObject:self.langModel.defaultParentWithUtilityMethods forKey:kSuperClass];
                [NSUserDefaults.standardUserDefaults synchronize];

                [self hanldeJson];

            }];
            view;
        });
    }
    return _popBtn;
}

-(NSButton *)btn{
    if (!_btn) {
        _btn = ({
            NSButton *view = [[NSButton alloc] initWithFrame:CGRectZero];
            view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            view.bezelStyle = NSBezelStyleRounded;
            
            view.title = @"保存";
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSLog(@"%@", control);
                [NSApp.mainWindow makeFirstResponder:nil];
                
                [self creatFile];

            }];
            view;
        });
    }
    return _btn;
}

- (NSDictionary *)langsDic{
    if (!_langsDic) {
        _langsDic = ({
            __block NSMutableDictionary * mdic = [NSMutableDictionary dictionary];
            NSArray * list = [NSBundle.mainBundle URLsForResourcesWithExtension:@"json" subdirectory:nil];
            [list enumerateObjectsUsingBlock:^(NSURL * _Nonnull url, NSUInteger idx, BOOL * _Nonnull stop) {
                NSData * data = [NSData dataWithContentsOfURL:url];
                
                NSError * error = nil;
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                if (error) {
                    [NSAlert showAlertWithError:error];
                    return ;
                }
                NNLanguageModel *langModel = [NNLanguageModel yy_modelWithJSON:dic];
                mdic[langModel.displayLangName] = langModel;
            }];
                
            mdic.copy;
        });
    }
    return _langsDic;
}
@end
