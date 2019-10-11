//
//  JsonToModelNewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/8/14.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "JsonToModelNewController.h"
#import "NNHeaderView.h"
#import "NSTableCellViewTen.h"

#import "NoodleLineNumberView.h"

#import "ESJsonFormatManager.h"
#import "ESJsonFormat.h"
#import "ESClassInfo.h"
#import "ESJsonFormatSetting.h"
#import "ESPair.h"
#import "FileManager.h"

#import "DataModel.h"

#import <YYModel/YYModel.h>
#import "BNLanguageModel.h"
#import "BNClassInfoModel.h"

#import <QuartzCore/QuartzCore.h>

@interface JsonToModelNewController ()<NSTableViewDataSource, NSTableViewDelegate, NSTextViewDelegate, NSTextFieldDelegate, NSTextDelegate>

@property (nonatomic, strong) NNTextView *textView;
@property (nonatomic, strong) NNTableView *tableView;

@property (nonatomic, strong) NNView *bottomView;
@property (nonatomic, strong) NNTextField *textField;
@property (nonatomic, strong) NNTextField *textFieldTwo;
@property (nonatomic, strong) NNTextField *textFieldThree;
@property (nonatomic, strong) NNTextLabel *textLabel;

@property (nonatomic, strong) NNTextLabel *valueTypeLab;
@property (nonatomic, strong) NSPopUpButton *popBtn;
@property (nonatomic, strong) NSButton *btn;

@property (nonatomic, strong) NSString *hFilename;
@property (nonatomic, strong) NSString *mFilename;

@property (nonatomic, strong) NSDictionary * langsDic;
@property (nonatomic, strong) BNLanguageModel * langModel;
@property (nonatomic, strong) BNClassInfoModel * classFileModel;
@property (nonatomic, strong) NSMutableArray * dataList;

@property (nonatomic, strong) NSArray * typeList;

@end

@implementation JsonToModelNewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.title = @"Home";
    
    
    [NSUserDefaults.standardUserDefaults setObject:@"BN" forKey:kClassPrefix];
    [NSUserDefaults.standardUserDefaults setObject:@"RootModel" forKey:kRootClass];
    [NSUserDefaults.standardUserDefaults setObject:@"NSObject" forKey:kSuperClass];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    self.textField.stringValue = [NSUserDefaults.standardUserDefaults objectForKey:kClassPrefix];
    self.textFieldTwo.stringValue = [NSUserDefaults.standardUserDefaults objectForKey:kRootClass];
    self.textFieldThree.stringValue = [NSUserDefaults.standardUserDefaults objectForKey:kSuperClass];
    
    DDLog(@"%@_%@_%@",self.textField.stringValue, self.textFieldTwo.stringValue, self.textFieldThree.stringValue);
    
    [self.view addSubview:self.textView.enclosingScrollView];
    [self.view addSubview:self.tableView.enclosingScrollView];
    [self.view addSubview:self.bottomView];
    [NoodleLineNumberView setupLineNumberWithTextView:self.textView];
    
    for (NSInteger i = 0; i < 2; i++) {
        BNClassInfoModel *classModel = [[BNClassInfoModel alloc]init];
        [self.dataList addObject:classModel];
    }
    
    [self updateLanguages];
    [self readFile];
    
    NSApplication.windowDefault.minSize = CGSizeMake(kScreenWidth*0.5, kScreenHeight*0.5);
    
    //    [self.view getViewLayer];
}

- (void)viewWillAppear{
    [super viewWillAppear];
    
    NSString * titleOfSelectedItem = [NSUserDefaults.standardUserDefaults objectForKey:kDisplayName];
    DDLog(@"titleOfSelectedItem_%@", titleOfSelectedItem);
    [self.popBtn selectItemWithTitle:titleOfSelectedItem];
    
    //    [self.tableView reloadData];
    
}

-(void)viewDidAppear{
    [super viewDidAppear];
    
    NSString * folderPath = @"/Users/shang/Downloads";
    [NSUserDefaults.standardUserDefaults setObject:folderPath forKey:kFolderPath];
    
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    [self.textView.enclosingScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(400);
        make.bottom.equalTo(self.view).offset(-45);
    }];
    
    [self.tableView.enclosingScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.textView.enclosingScrollView.right).offset(15);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-45);
    }];
    
    [self.bottomView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.enclosingScrollView.bottom).offset(kPadding);
        make.left.right.equalTo(self.bottomView.superview);
        make.bottom.equalTo(self.bottomView.superview);
    }];
    
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.left.equalTo(self.bottomView.superview).offset(kX_GAP);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.textFieldTwo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.left.equalTo(self.textField.right).offset(kX_GAP);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.textFieldThree makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.left.equalTo(self.textFieldTwo.right).offset(kX_GAP);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.textLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.left.equalTo(self.textFieldThree.right).offset(kX_GAP);
        make.width.equalTo(150);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.right.equalTo(self.bottomView.superview).offset(-kX_GAP);
        make.width.equalTo(80);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.popBtn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.right.equalTo(self.btn.left).offset(-kX_GAP);
        make.width.equalTo(160);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.valueTypeLab makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.right.equalTo(self.popBtn.left).offset(-kX_GAP);
        make.width.equalTo(80);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    // 重设宽度
    //    CGRect rect = self.tableView.frame;
    //    NSTableColumn * column = self.tableView.tableColumns.firstObject;
    //    column.width = CGRectGetWidth(rect);
    //    column.maxWidth = CGFLOAT_MAX;
    
    //    [self.tableView reloadData];
}


#pragma mark -NSTableView
//返回行数
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    BOOL isSwift = [NSUserDefaults.standardUserDefaults boolForKey:kIsSwift];
    NSInteger count = isSwift ? 1 : 2;
    return count;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    BOOL isSwift = [NSUserDefaults.standardUserDefaults boolForKey:kIsSwift];
    CGFloat height = isSwift ? (CGRectGetHeight(NSApp.keyWindow.frame) - 50 - 40) : (CGRectGetHeight(NSApp.keyWindow.frame) - 50)*0.5;
    return height;
}

//// 使用自定义cell显示数据
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSInteger item = [tableView.tableColumns indexOfObject:tableColumn];
    //获取表格列的标识符
    NSString *columnID = tableColumn.identifier;
    //    NSLog(@"columnID : %@ ,row : %@, item: %@",columnID, @(row), @(item));
    
    static NSString *identifier = @"NSTableCellViewTen";
    NSTableCellViewTen *cell = [NSTableCellViewTen viewWithTableView:tableView identifier:identifier owner:self];
    cell.checkBox.hidden = true;
    
    if (self.dataList.count > 0) {
        BNClassInfoModel * classModel = self.dataList[row];
        
        BOOL isSwift = [NSUserDefaults.standardUserDefaults boolForKey:kIsSwift];
        if (!isSwift) {
            cell.textLabel.stringValue = [classModel.className stringByAppendingString:(row == 0) ? @".h" : @".m"];
            cell.textView.string = (row == 0) ? classModel.hContent : classModel.mContent;
            
        } else {
            cell.textLabel.stringValue = [classModel.className stringByAppendingString:@".swift"];
            cell.textView.string = classModel.hContent;
            
        }
    }
    return cell;
}

//设置每行容器视图
//- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
//    NNTableRowView * rowView = [[NNTableRowView alloc]init];
//    rowView.backgroundColor = NSColor.yellowColor;
//    return rowView;
//}

#pragma mark - 是否可以选中单元格
-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    //设置cell选中高亮颜色
    NSTableRowView *rowView = [tableView rowViewAtRow:row makeIfNecessary:NO];
    rowView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;
    rowView.emphasized = false;
    
    NSLog(@"shouldSelectRow : %ld",row);
    return YES;
}

// 点击表头
- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn{
    
    DDLog(@"%@", tableColumn);
}

//选中的响应
-(void)tableViewSelectionDidChange:(nonnull NSNotification *)notification{
    //    NSTableView *tableView = notification.object;
    //    NSLog(@"didSelect：%@",notification);
}

- (NSString *)tableView:(NSTableView *)tableView toolTipForCell:(NSCell *)cell rect:(NSRectPointer)rect tableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row mouseLocation:(NSPoint)mouseLocation{
    NSInteger item = [tableView.tableColumns indexOfObject:tableColumn];
    NSString * string = [NSString stringWithFormat:@"{%@,%@}", @(row), @(item)];
    return string;
}

- (BOOL)tableView:(NSTableView *)tableView shouldShowCellExpansionForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row{
    return true;
}

- (BOOL)tableView:(NSTableView *)tableView shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return YES;
}

#pragma mark -NSTextDelegate

- (void)textDidChange:(NSNotification *)notification{
    NSTextView * view = notification.object;
    //    NSLog(@"length:%@", @(view.string.length));
    //    NSLog(@"containerSize:%@", @(view.textContainer.containerSize));
    //    [view scrollRangeToVisible: NSMakeRange(FLT_MAX, FLT_MAX)];
    if (view.string.length > 0) {
        [self hanldeJson];
    }
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
                          @(101): kRootClass,
                          @(102): kSuperClass,
                          
                          };
    NSString * defaultsKey = dic[@(textField.tag)];
    [NSUserDefaults.standardUserDefaults setObject:textField.stringValue forKey:defaultsKey];
    [NSUserDefaults.standardUserDefaults synchronize];
    //    DDLog(@"%@_%@_%@_%@",@(textField.tag), defaultsKey, textField.stringValue, [NSUserDefaults.standardUserDefaults objectForKey:defaultsKey]);
    [self hanldeJson];
    
}

#pragma mark -funtions

- (void)readFile{
    NSString *path = [NSBundle.mainBundle pathForResource:@"appinfo" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    id obj = content.objValue;
    //    DDLog(@"%@", obj);
    
    self.textView.string = [(NSDictionary *)obj jsonString];
    
    [self hanldeJson];
}

- (void)clearFileOutputPath {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:kFolderPath];
    [NSUserDefaults.standardUserDefaults synchronize];
    NSAlert *alert = [[NSAlert alloc] init];
    alert.messageText = @"\nClear Success.";
    [alert runModal];
    
}

- (void)hanldeJson{
    //    DDLog(@"titleOfSelectedItem_%@", self.popBtn.titleOfSelectedItem);
    
    [self setupDefaultWithSender:self.popBtn];
    if (self.textFieldThree.stringValue.length > 0) {
        [NSUserDefaults.standardUserDefaults setObject:self.textFieldThree.stringValue forKey:kSuperClass];
        [NSUserDefaults.standardUserDefaults synchronize];
    }
    
    //    self.hTextView.string = @"";
    //    self.mTextView.string = @"";
    
    id result = self.textView.string.objValue;
    self.textLabel.stringValue = result ? @"Valid JSON Structure" : @"JSON isn't valid";
    self.textLabel.textColor = result ? NSColor.greenColor : NSColor.redColor;
    
    if (!result) {
        NSAlert * alert = [NSAlert createAlertTitle:@"警告" msg:@"Error：Json is invalid" btnTitles:@[kActionTitle_Know]];
        [alert beginSheetModalHandler:^(NSModalResponse returnCode) {
            DDLog(@"%@", @(returnCode));
        }];
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
        bool isSwift = [NSUserDefaults.standardUserDefaults boolForKey:kIsSwift];
        if (!isSwift) {
            BNClassInfoModel *classModel = self.dataList.firstObject;
            classModel.className = classInfo.className;
            classModel.hContent = [classInfo classDescWithFirstFile:true];
            
            BNClassInfoModel *classModelOne = self.dataList.lastObject;
            classModelOne.className = classInfo.className;
            classModelOne.mContent = [classInfo classDescWithFirstFile:false];
            if (self.valueTypeLab.isSelectable == true) {
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"assign) NSInteger " withString:@"copy) NSString *"];
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"assign) long long " withString:@"copy) NSString *"];
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"assign) CGFloat " withString:@"copy) NSString *"];
            }
            
        } else {
            BNClassInfoModel *classModel = self.dataList.firstObject;
            classModel.className = classInfo.className;
            classModel.hContent = [classInfo classDescWithFirstFile:true];
            
            classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"import UIKit" withString:self.langModel.staticImports];
            NSString * tmp = [NSString stringWithFormat:@"NSObject, %@ {", self.langModel.defaultParentWithUtilityMethods];
            classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"NSObject {" withString:tmp];
            if (self.valueTypeLab.isSelectable == true) {
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@": Int = 0" withString:@": String = \"\""];
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@": Double = 0" withString:@": String = \"\""];
            }
        }
       
        [self.tableView reloadData];
    }
    
}

- (void)creatFile{
    BNClassInfoModel *classModelH = self.dataList.firstObject;
    BNClassInfoModel *classModelM = self.dataList.lastObject;
    NSString * hContent = classModelH.hContent;
    NSString * mContent = classModelM.mContent;
    
    NSString *folderPath = [NSUserDefaults.standardUserDefaults valueForKey:kFolderPath];
    if (folderPath) {
        [FileManager.sharedInstance createFileWithFolderPath:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:hContent mContent:mContent];
        [NSWorkspace.sharedWorkspace openFile:folderPath];
        
    } else {
        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];
        if (panel.runModal == NSModalResponseOK) {
            folderPath = [panel.URLs.firstObject relativePath];
            [NSUserDefaults.standardUserDefaults setValue:folderPath forKey:kFolderPath];
            NSLog(@"%@",folderPath);
            [FileManager.sharedInstance createFileWithFolderPath:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:hContent mContent:mContent];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
    }
}

- (void)updateLanguages{
    NSArray * items = [self.langsDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self.popBtn removeAllItems];
    [self.popBtn addItemsWithTitles:items];
    
}

- (void)setupDefaultWithSender:(NSPopUpButton *)sender{
    NSString * titleOfSelectedItem = sender.titleOfSelectedItem;
    self.langModel = self.langsDic[titleOfSelectedItem];
    //    DDLog(@"titleOfSelectedItem_%@", titleOfSelectedItem);
    
    [NSUserDefaults.standardUserDefaults setObject:titleOfSelectedItem forKey:kDisplayName];
    bool isSwift = [titleOfSelectedItem containsString:@"Swift"] || [titleOfSelectedItem containsString:@"swift"];
    [NSUserDefaults.standardUserDefaults setBool:isSwift forKey:kIsSwift];
    [NSUserDefaults.standardUserDefaults setObject:self.langModel.defaultParentWithUtilityMethods forKey:kSuperClass];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    [NSUserDefaults setArcObject:self.langModel forKey:@"langModel"];
    [NSUserDefaults synchronize];
    id langModel = [NSUserDefaults arcObjectForKey:@"langModel"];
}

#pragma mark -lazy

-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView * view = [NNTextView createTextViewRect:CGRectZero];
            view.delegate = self;
            view.string = @"NSScrollView上无法滚动的NSTextView";
            view.font = [NSFont systemFontOfSize:12];
            
            view;
        });
    }
    return _textView;
}

-(NNTableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            NNTableView *view = [NNTableView createTableViewRect:CGRectZero];
            view.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;//行高亮的风格
//            view.delegate = self;
//            view.dataSource = self;
            
            NSArray * columns = @[@"columeOne", ];
            [columns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSTableColumn * column = [NSTableColumn createWithIdentifier:obj title:obj];
                
                [view addTableColumn:column];
            }];
            view;
        });
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NNView *)bottomView{
    if (!_bottomView) {
        _bottomView = ({
            NNView *view = [[NNView alloc]init];
            view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
            
            [view addSubview:self.textField];
            [view addSubview:self.textFieldTwo];
            [view addSubview:self.textFieldThree];
            [view addSubview:self.textLabel];
            
            [view addSubview:self.btn];
            [view addSubview:self.popBtn];
            [view addSubview:self.valueTypeLab];

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
            view.font = [NSFont systemFontOfSize:13];
            
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
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Root Class name"];
            view.bordered = true;  ///是否显示边框
            view.font = [NSFont systemFontOfSize:13];
            
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
            NNTextField *view = [NNTextField createTextFieldRect:CGRectZero placeholder:@"Supper Class name"];
            view.bordered = true;  ///是否显示边框
            view.font = [NSFont systemFontOfSize:13];
            
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

-(NNTextLabel *)textLabel{
    if (!_textLabel) {
        _textLabel = ({
            NNTextLabel * view = [[NNTextLabel alloc]initWithFrame:CGRectZero];
            view.bordered = false;  ///是否显示边框
            view.font = [NSFont systemFontOfSize:15];
            view.alignment = NSTextAlignmentCenter;
            
            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.backgroundColor = NSColor.clearColor;
            
            view;
        });
    }
    return _textLabel;
}

-(NNTextLabel *)valueTypeLab{
    if (!_valueTypeLab) {
        _valueTypeLab = ({
            NNTextLabel * view = [[NNTextLabel alloc]initWithFrame:CGRectZero];
            view.bordered = false;  ///是否显示边框
            view.font = [NSFont systemFontOfSize:13];
            view.textColor = NSColor.grayColor;
            view.alignment = NSTextAlignmentCenter;
            
            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.backgroundColor = NSColor.clearColor;
            view.stringValue = self.typeList.firstObject;
            view.mouseDownBlock = ^(NNTextLabel * _Nonnull sender) {
                sender.selectable = !sender.selectable;
                sender.stringValue = sender.selectable == false ? self.typeList.firstObject : self.typeList.lastObject;
                sender.textColor = sender.selectable == false ? NSColor.grayColor : NSColor.redColor;
                
                [self hanldeJson];
            };
            view;
        });
    }
    return _valueTypeLab;
}

-(NSArray *)typeList{
    if (!_typeList) {
        _typeList = @[@"默认类型", @"字符串类型",];
    }
    return _typeList;
}

-(NSPopUpButton *)popBtn{
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

-(NSDictionary *)langsDic{
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
                BNLanguageModel *langModel = [BNLanguageModel yy_modelWithJSON:dic];
                mdic[langModel.displayLangName] = langModel;
            }];
            
            mdic.copy;
        });
    }
    return _langsDic;
}

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
