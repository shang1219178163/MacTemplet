//
//  HomeViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HomeViewController.h"
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

NSString *const kDefaultsClassPrefix = @"keyClassPrefix";
NSString *const kDefaultsRootClassName = @"SuperClass";

NSString *const kDefaultsSwift = @"isSwift";
NSString *const kDefaultsPodName = @"keyPodName";

NSString *const kDefaultsFolderPath = @"folderPath";
//NSString *const kDefaultsClassPrefix = @"keyClassPrefix";
//NSString *const kDefaultsClassPrefix = @"keyClassPrefix";
//NSString *const kDefaultsClassPrefix = @"keyClassPrefix";

#define ESRootClassName @"RootModel"
#define ESItemClassName @"ItemModel"
#define ESArrayKeyName @"esArray"

@interface HomeViewController ()<NSTextViewDelegate, NSTextFieldDelegate, NSTextDelegate>

@property (nonatomic, strong) NNTextView *textView;
@property (nonatomic, strong) NNTextView *hTextView;
@property (nonatomic, strong) NNTextView *mTextView;

@property (nonatomic, strong) NNView *bottomView;
@property (nonatomic, strong) NNTextField *textField;
@property (nonatomic, strong) NNTextField *textFieldTwo;

@property (nonatomic, strong) NSSegmentedControl *segmentCtl;

@property (nonatomic, strong) NSPopUpButton *popBtn;
@property (nonatomic, strong) NSButton *btn;

@property (nonatomic, strong) NSArray *list;

@property (nonatomic, strong) NSString *hFilename;
@property (nonatomic, strong) NSString *mFilename;

//@property (nonatomic, strong) NNTableView *tableView;

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

    [self.bottomView addSubview:self.btn];
    [self.bottomView addSubview:self.popBtn];
    [self.bottomView addSubview:self.segmentCtl];
    [self.view addSubview:self.bottomView];

//    [self.view getViewLayer];
    
    [self readFile];
    
}

-(void)viewDidAppear{
    [super viewDidAppear];
    
    NSString * folderPath = @"/Users/shang/Downloads";
    [NSUserDefaults.standardUserDefaults setObject:folderPath forKey:@"folderPath"];

    [NSUserDefaults.standardUserDefaults setObject:@"BN" forKey:kDefaultsClassPrefix];
    [NSUserDefaults.standardUserDefaults setObject:@"NSObject" forKey:kDefaultsRootClassName];
    [NSUserDefaults.standardUserDefaults setBool:false forKey:@"isSwift"];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    [self testNSFileManager];
}

-(void)testNSFileManager{
    NSString * folderPath = @"/Users/shang/Downloads";
    NSFileManager *manager = NSFileManager.defaultManager;
    NSString *fileAtPath = [folderPath stringByAppendingPathComponent:@"BNRootModel.h"];
    bool isSuccess = [manager createFileAtPath:fileAtPath contents:[@"22222" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    bool isExist = [NSFileManager.defaultManager fileExistsAtPath:fileAtPath];
    bool isWritable = [NSFileManager.defaultManager isWritableFileAtPath:folderPath];
    
    NSError * error = nil;
    [@"2222" writeToFile:fileAtPath atomically:false encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSAlert *alert = [NSAlert alertWithError:error];
        [alert runModal];
    }
    
    DDLog(@"__%@_%@_%@", @(isWritable), @(isExist), @(isSuccess));
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
        make.width.equalTo(120);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.textFieldTwo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.left.equalTo(self.textField.right).offset(gap);
        make.width.equalTo(120);
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
        make.width.equalTo(120);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
    [self.segmentCtl makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(padding);
        make.right.equalTo(self.popBtn.left).offset(-gap);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-padding);
    }];
    
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
    DDLog(@"%@",textField.stringValue);
    
    if (textField == self.textField || textField == self.textFieldTwo) {
        NSString * defaultsKey = (textField == self.textField) ? kDefaultsClassPrefix : kDefaultsRootClassName;
        [NSUserDefaults.standardUserDefaults setObject:textField.stringValue forKey:defaultsKey];
        [NSUserDefaults.standardUserDefaults synchronize];
        
    }
    else {
        DDLog(@"未知错误:%@",textField);
    }
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
    [NSUserDefaults.standardUserDefaults removeObjectForKey:@"folderPath"];
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
    ESClassInfo *classInfo = [self dealClassNameWithJsonResult:result];
    [self outputResult:classInfo];
    
}

#pragma mark - Change ESJsonFormat
/**
 *  初始类名，RootClass/JSON为数组/创建文件与否
 *
 *  @param result JSON转成字典或者数组
 *
 *  @return 类信息
 */
- (ESClassInfo *)dealClassNameWithJsonResult:(id)result{
    __block ESClassInfo *classInfo = nil;
    //如果当前是JSON对应是字典
    if ([result isKindOfClass:[NSDictionary class]]) {
        //如果是生成到文件，提示输入Root class name
        if (![NSUserDefaults.standardUserDefaults valueForKey:@"folderPath"]) {
            NSString *className = [[NSUserDefaults objectForKey:kDefaultsClassPrefix] stringByAppendingString:ESRootClassName];
            classInfo = [[ESClassInfo alloc] initWithClassNameKey:ESRootClassName ClassName:className classDic:result];
            if (self.isSwift) {
                self.hFilename = [NSString stringWithFormat:@"%@.swift",className];
                self.mFilename = @"";

            } else {
                self.hFilename = [NSString stringWithFormat:@"%@.h",className];
                self.mFilename = [NSString stringWithFormat:@"%@.m",className];

            }
            [self dealPropertyNameWithClassInfo:classInfo];
            
        } else {
            //不生成到文件，Root class 里面用户自己创建
            NSString *className = [[NSUserDefaults objectForKey:kDefaultsClassPrefix] stringByAppendingString:ESRootClassName];
            classInfo = [[ESClassInfo alloc] initWithClassNameKey:ESRootClassName ClassName:className classDic:result];
            [self dealPropertyNameWithClassInfo:classInfo];
            
        }
    } else if ([result isKindOfClass:[NSArray class]]){
        if ([NSUserDefaults.standardUserDefaults valueForKey:@"folderPath"]) {
            //当前是JSON代表数组，生成到文件需要提示用户输入Root Class name，
            NSString *className = [[NSUserDefaults objectForKey:kDefaultsClassPrefix] stringByAppendingString:ESRootClassName];
                //输入完毕之后，将这个class设置
            NSDictionary *dic = [NSDictionary dictionaryWithObject:result forKey:className];
            classInfo = [[ESClassInfo alloc] initWithClassNameKey:ESRootClassName ClassName:className classDic:dic];
            
            [self dealPropertyNameWithClassInfo:classInfo];
        } else {
            //Root class 已存在，只需要输入JSON对应的key的名字
            NSString *className = [[NSUserDefaults objectForKey:kDefaultsClassPrefix] stringByAppendingString:ESRootClassName];
            NSDictionary *dic = [NSDictionary dictionaryWithObject:result forKey:className];
            classInfo = [[ESClassInfo alloc] initWithClassNameKey:ESRootClassName ClassName:className classDic:dic];
            [self dealPropertyNameWithClassInfo:classInfo];
        }
    }
    return classInfo;
}


/**
 *  处理属性名字(用户输入属性对应字典对应类或者集合里面对应类的名字)
 *
 *  @param classInfo 要处理的ClassInfo
 *
 *  @return 处理完毕的ClassInfo
 */
- (ESClassInfo *)dealPropertyNameWithClassInfo:(ESClassInfo *)classInfo{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:classInfo.classDic];
    for (NSString *key in dic) {
        //取出的可能是NSDictionary或者NSArray
        id obj = dic[key];
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {

            NSString *msg = [NSString stringWithFormat:@"The '%@' correspond class name is:",key];
            if ([obj isKindOfClass:[NSArray class]]) {
                //May be 'NSString'，will crash
                if (!([[obj firstObject] isKindOfClass:[NSDictionary class]] || [[obj firstObject] isKindOfClass:[NSArray class]])) {
                    continue;
                }
                msg = [NSString stringWithFormat:@"The '%@' child items class name is:",key];
            }
//            __block NSString *childClassName = [key capitalizedString];
            __block NSString *childClassName = [[NSUserDefaults.standardUserDefaults objectForKey:kDefaultsClassPrefix] stringByAppendingString: key.capitalizedString];
            if (![childClassName containsString:@"Model"]) {
                childClassName = [childClassName stringByAppendingString:@"Model"];
            }
            
            //如果当前obj是 NSDictionary 或者 NSArray，继续向下遍历
            if ([obj isKindOfClass:[NSDictionary class]]) {
                ESClassInfo *childClassInfo = [[ESClassInfo alloc] initWithClassNameKey:key ClassName:childClassName classDic:obj];
                [self dealPropertyNameWithClassInfo:childClassInfo];
                //设置classInfo里面属性对应class
                [classInfo.propertyClassDic setObject:childClassInfo forKey:key];
            }else if([obj isKindOfClass:[NSArray class]]){
                //如果是 NSArray 取出第一个元素向下遍历
                NSArray *array = obj;
                if (array.firstObject) {
                    NSObject *obj = array.firstObject;
                    //May be 'NSString'，will crash
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        ESClassInfo *childClassInfo = [[ESClassInfo alloc] initWithClassNameKey:key ClassName:childClassName classDic:(NSDictionary *)obj];
                        [self dealPropertyNameWithClassInfo:childClassInfo];
                        //设置classInfo里面属性类型为 NSArray 情况下，NSArray 内部元素类型的对应的class
                        [classInfo.propertyArrayDic setObject:childClassInfo forKey:key];
                    }
                }
            }
        }
    }
    return classInfo;
}

-(void)outputResult:(ESClassInfo*)classInfo{
    
    if ([NSUserDefaults.standardUserDefaults valueForKey:@"folderPath"]) {
        //选择保存路径
        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];
        if ([panel runModal] == NSModalResponseOK) {
            NSString *folderPath = [panel.URLs.firstObject relativePath];
            [classInfo createFileWithFolderPath:folderPath];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
        
    } else {
        if (!self.hTextView) return;
        if (!self.isSwift) {
            NSString *mContent = [NSString stringWithFormat:@"%@\n%@",classInfo.classContentForM,classInfo.classInsertTextViewContentForM];
            self.mTextView.string = mContent;
            
            NSString * hContent = [NSString stringWithFormat:@"%@\n%@\n%@",classInfo.atClassContent, classInfo.classContentForH, classInfo.classInsertTextViewContentForH];
            self.hTextView.string = hContent;
            
        } else {
            NSString * hContent = [NSString stringWithFormat:@"%@\n\n%@",classInfo.classContentForH, classInfo.classInsertTextViewContentForH];
            self.hTextView.string = hContent;
        
        }
        
        [self creatFile];
    }
}

- (void)creatFile{
    NSString *folderPath = [NSUserDefaults.standardUserDefaults valueForKey:@"folderPath"];
    if (folderPath) {
        [FileManager.sharedInstance handleBaseData:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:self.hTextView.string mContent:self.mTextView.string];
        [NSWorkspace.sharedWorkspace openFile:folderPath];
        
    } else {
        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];

        if (panel.runModal == NSModalResponseOK) {
            folderPath = [panel.URLs.firstObject relativePath];
            [NSUserDefaults.standardUserDefaults setValue:folderPath forKey:@"folderPath"];
            NSLog(@"%@",folderPath);
            [FileManager.sharedInstance handleBaseData:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:self.hTextView.string mContent:self.mTextView.string];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
    }
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
            view.font = [NSFont systemFontOfSize:14];

            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.delegate = self;

            view;
        });
    }
    return _textField;
}

-(NNTextField *)textFieldTwo{
    if (!_textFieldTwo) {
        _textFieldTwo = ({
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Root Class name"];
            view.bordered = true;  ///是否显示边框

            view.alignment = NSTextAlignmentCenter;
            view.isTextAlignmentVerticalCenter = true;
            view.font = [NSFont systemFontOfSize:14];

            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;

            view.delegate = self;
            
            view;
        });
    }
    return _textFieldTwo;
}

-(NSSegmentedControl *)segmentCtl{
    if (!_segmentCtl) {
        _segmentCtl = ({
            NSArray *items = @[@"Swift", @"OC"];
            NSSegmentedControl * view = [[NSSegmentedControl alloc] init];
            view.items = items;
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSSegmentedControl *sender = (NSSegmentedControl *)control;
                NSLog(@"%@", @(sender.selectedSegment));
                
                BOOL isSwift = (sender.selectedSegment == 0) ? YES : NO;
                [NSUserDefaults.standardUserDefaults setBool:isSwift forKey:kDefaultsSwift];
                [NSUserDefaults.standardUserDefaults synchronize];
                
                [self clearFileOutputPath];

            } forControlEvents:NSEventMaskLeftMouseDown];
            view;
        });
    }
    return _segmentCtl;
}

- (NSPopUpButton *)popBtn{
    if (!_popBtn) {
        _popBtn = ({
            NSPopUpButton *view = [[NSPopUpButton alloc] initWithFrame:CGRectZero pullsDown:false];
            view.autoenablesItems = true;
            
            NSArray *list = @[@"北京", @"上海", @"广州", @"深圳"];
            [view addItemsWithTitles:list];
            [view addActionHandler:^(NSControl * _Nonnull control) {
                NSPopUpButton *sender = (NSPopUpButton *)control;
                NSLog(@"%@", sender.titleOfSelectedItem);
                [NSUserDefaults setObject:sender.titleOfSelectedItem forKey:kDefaultsPodName];

            } forControlEvents:NSEventMaskLeftMouseDown];
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
                
                [self hanldeJson];

            } forControlEvents:NSEventMaskLeftMouseDown];
            view;
        });
    }
    return _btn;
}

- (BOOL)isSwift{
    return [NSUserDefaults.standardUserDefaults boolForKey:kDefaultsSwift];
}

@end
