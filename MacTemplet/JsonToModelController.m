//
//  JsonToModelController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/8/14.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "JsonToModelController.h"
#import "NNHeaderView.h"
#import "NSTableCellViewTen.h"

#import "NoodleLineNumberView.h"

#import "ESJsonFormatManager.h"
#import "ESJsonFormat.h"
#import "ESClassInfo.h"
#import "ESJsonFormatSetting.h"
#import "ESPair.h"
#import "NNFileManager.h"

#import "DataModel.h"

#import <YYModel/YYModel.h>
#import "NNLanguageModel.h"
#import "NNClassInfoModel.h"

#import <QuartzCore/QuartzCore.h>
#import "NSApplication+Ext.h"


#define MAS_SHORTHAND_GLOBALS
#define MAS_SHORTHAND
#import "Masonry.h"


#import "NNGloble.h"
#import "Const.h"

#import <SwiftExpand-Swift.h>
#import "MacTemplet-Swift.h"


@interface JsonToModelController ()<NSTableViewDataSource, NSTableViewDelegate, NSTextViewDelegate, NSTextFieldDelegate, NSTextDelegate>


@property (nonatomic, strong) NNTextView *textView;
@property (nonatomic, strong) NNTableView *tableView;

@property (nonatomic, strong) NNView *bottomView;
@property (nonatomic, strong) NNTextField *textField;
@property (nonatomic, strong) NNTextField *textFieldTwo;
@property (nonatomic, strong) NNTextField *textFieldThree;
@property (nonatomic, strong) HHLabel *textLabel;

@property (nonatomic, strong) HHLabel *valueTypeLab;
@property (nonatomic, strong) NSPopUpButton *popBtn;
@property (nonatomic, strong) NSButton *btn;

@property (nonatomic, strong) NSString *hFilename;
@property (nonatomic, strong) NSString *mFilename;

@property (nonatomic, strong) NSDictionary *langsDic;
@property (nonatomic, strong) NNLanguageModel *langModel;
@property (nonatomic, strong) NNClassInfoModel *classFileModel;
@property (nonatomic, strong) NSMutableArray *dataList;

@property (nonatomic, strong) NSArray *types;

@end

@implementation JsonToModelController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [NSUserDefaults.standardUserDefaults setObject:@"NN" forKey:kClassPrefix];
    [NSUserDefaults.standardUserDefaults setObject:@"RootModel" forKey:kRootClass];
    [NSUserDefaults.standardUserDefaults setObject:@"NSObject" forKey:kSuperClass];
    [NSUserDefaults.standardUserDefaults synchronize];
    
    self.textField.stringValue = [NSUserDefaults.standardUserDefaults objectForKey:kClassPrefix];
    self.textFieldTwo.stringValue = [NSUserDefaults.standardUserDefaults objectForKey:kRootClass];
    self.textFieldThree.stringValue = [NSUserDefaults.standardUserDefaults objectForKey:kSuperClass];
//    DDLog(@"%@_%@_%@",self.textField.stringValue, self.textFieldTwo.stringValue, self.textFieldThree.stringValue);
    
    [self.view addSubview:self.textView.enclosingScrollView];
    [self.view addSubview:self.tableView.enclosingScrollView];
    [self.view addSubview:self.bottomView];
    [NoodleLineNumberView setupLineNumberWithTextView:self.textView];
    
    for (NSInteger i = 0; i < 2; i++) {
        NNClassInfoModel *classModel = [[NNClassInfoModel alloc]init];
        [self.dataList addObject:classModel];
    }
    
    [self updateLanguages];
    [self readFile];
    
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(handleNotifation:)
                                               name:NSWindowDidBecomeKeyNotification
                                             object:nil];

}

- (void)handleNotifation:(NSNotification *)n {
//    DDLog(@"%@", n);
    [self.tableView reloadData];
}


-(void)viewDidLayout{
    [super viewDidLayout];
    
    [self.textView.enclosingScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.width.equalTo(self.view).multipliedBy(0.5);
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
        make.width.equalTo(100);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.textFieldTwo makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.left.equalTo(self.textField.right).offset(kX_GAP);
        make.width.equalTo(100);
        make.bottom.equalTo(self.bottomView.superview).offset(-kPadding);
    }];
    
    [self.textFieldThree makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.superview).offset(kPadding);
        make.left.equalTo(self.textFieldTwo.right).offset(kX_GAP);
        make.width.equalTo(100);
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
}

- (void)viewWillAppear{
    [super viewWillAppear];
    
    NSString *titleOfSelectedItem = [NSUserDefaults.standardUserDefaults objectForKey:kDisplayName];
    [self.popBtn selectItemWithTitle:titleOfSelectedItem];
}

-(void)viewDidAppear{
    [super viewDidAppear];
    
    NSString *folderPath = @"/Users/shang/Downloads";
    [NSUserDefaults.standardUserDefaults setObject:folderPath forKey:kFolderPath];
}


#pragma mark - NSTableView
//返回行数
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    NSInteger count = NSApplication.isSwift ? 1 : 2;
    return count;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    CGFloat tableViewH = CGRectGetHeight(tableView.frame);
    CGFloat height = NSApplication.isSwift ? tableViewH : tableViewH*0.5;
    return height > 0 ? height : tableView.rowHeight;
}

//// 使用自定义cell显示数据
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
//    tableColumn.resizingMask = NSTableColumnAutoresizingMask;
//    NSInteger columnIndex = [tableView.tableColumns indexOfObject:tableColumn];
//    //获取表格列的标识符
//    NSString *columnID = tableColumn.identifier;
//    DDLog(@"columnID : %@ ,row : %@, item: %@",columnID, @(row), @(item));
//    tableColumn.width = CGRectGetWidth(tableView.bounds)/tableView.tableColumns.count;
    
//    static NSString *identifier = @"NSTableCellViewTen";
//    NSTableCellViewTen *cell = [NSTableCellViewTen makeViewWithTableView:tableView identifier:identifier owner:self];
    NSTableCellViewTen *cell = [NSTableCellViewTen makeViewWithTableView:tableView owner:self];

//    NSTableCellViewTen *cell = [tableView makeViewWithIdentifier:identifier owner:nil];
//    if (!cell) {
//        cell = [[NSTableCellViewTen alloc]initWithFrame:cell.bounds];
//        cell.identifier = identifier;
//    }
    
//    if ([tableColumn.identifier isEqualToString:identifier]) {
//        DDLog(@"%p", identifier);
//    }

    cell.checkBox.hidden = true;
    if (self.dataList.count == 0) {
        return cell;
    }
    NNClassInfoModel *classModel = self.dataList[row];
    
    BOOL isSwift = NSApplication.isSwift;
    if (!isSwift) {
        cell.textLabel.stringValue = [classModel.className stringByAppendingString:(row == 0) ? @".h" : @".m"];
        cell.textView.string = (row == 0) ? classModel.hContent : classModel.mContent;
        
    } else {
        cell.textLabel.stringValue = [classModel.className stringByAppendingString:@".swift"];
        cell.textView.string = classModel.hContent;
    }
    
    cell.textLabel.backgroundColor = NSColor.background;
//    [cell getViewLayer];
    return cell;
}

//设置每行容器视图
//- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
//    NNTableRowView *rowView = [[NNTableRowView alloc]init];
//    rowView.backgroundColor = NSColor.yellowColor;
//    return rowView;
//}

// - 是否可以选中单元格
-(BOOL)tableView:(NSTableView *)tableView shouldSelectRow:(NSInteger)row{
    //设置cell选中高亮颜色
    NSTableRowView *rowView = [tableView rowViewAtRow:row makeIfNecessary:NO];
    rowView.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;
    rowView.emphasized = false;
    
    DDLog(@"shouldSelectRow : %ld",row);
    return YES;
}

// 点击表头
- (void)tableView:(NSTableView *)tableView didClickTableColumn:(NSTableColumn *)tableColumn{
    DDLog(@"%@", tableColumn);
}

//选中的响应
- (void)tableViewSelectionDidChange:(nonnull NSNotification *)notification{
//    NSTableView *tableView = notification.object;
//    DDLog(@"didSelect：%@",notification);
}

- (NSString *)tableView:(NSTableView *)tableView
         toolTipForCell:(NSCell *)cell
                   rect:(NSRectPointer)rect
            tableColumn:(nullable NSTableColumn *)tableColumn
                    row:(NSInteger)row
          mouseLocation:(NSPoint)mouseLocation{
    NSInteger item = [tableView.tableColumns indexOfObject:tableColumn];
    NSString *string = [NSString stringWithFormat:@"{%@,%@}", @(row), @(item)];
    return string;
}

- (BOOL)tableView:(NSTableView *)tableView shouldShowCellExpansionForTableColumn:(nullable NSTableColumn *)tableColumn row:(NSInteger)row{
    return true;
}

- (BOOL)tableView:(NSTableView *)tableView shouldTrackCell:(NSCell *)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    return YES;
}

//#pragma mark - NSTextDelegate
- (void)textDidBeginEditing:(NSNotification *)notification{

}

- (void)textDidChange:(NSNotification *)notification{
    NSTextView * view = notification.object;
    DDLog(@"length:%@", @(view.string.length));
    DDLog(@"containerSize:%@", @(view.textContainer.containerSize));
    [view scrollRangeToVisible: NSMakeRange(FLT_MAX, FLT_MAX)];
    if (view.string.length > 0) {
        [self hanldeJson];
    }
}

- (void)textDidEndEditing:(NSNotification *)notification{
//    NSTextField *textField = (NSTextField *)notification.object;
//    DDLog(@"%@",textField.stringValue);
}

#pragma mark -NSControlTextEditingDelegate
- (void)controlTextDidBeginEditing:(NSNotification *)obj{
//    print("开始编辑")
}

- (void)controlTextDidChange:(NSNotification *)obj {
//    NSTextField *textField = (NSTextField *)obj.object;
//    DDLog(@"%@",textField.stringValue);
}

- (void)controlTextDidEndEditing:(NSNotification *)obj{
//    print("结束编辑")
//    NSTextField *textField = (NSTextField *)obj.object;
//    DDLog(@"%@",textField.stringValue);
    
    [NSUserDefaults.standardUserDefaults setObject:self.textField.stringValue forKey:kClassPrefix];
    [NSUserDefaults.standardUserDefaults setObject:self.textFieldTwo.stringValue forKey:kRootClass];
    [NSUserDefaults.standardUserDefaults setObject:self.textFieldThree.stringValue forKey:kSuperClass];
    [NSUserDefaults.standardUserDefaults synchronize];
    [self hanldeJson];
}

//- (BOOL)control:(NSControl *)control textView:(NSTextView *)fieldEditor doCommandBySelector:(SEL)commandSelector{
//    NSLog(@"Selector method is (%@)", NSStringFromSelector(commandSelector));
//    if (commandSelector == @selector(insertNewline:)) {
//        //Do something against ENTER key
//
//    } else if (commandSelector == @selector(deleteForward:)) {
//        //Do something against DELETE key
//
//    } else if (commandSelector == @selector(deleteBackward:)) {
//        //Do something against BACKSPACE key
//
//    } else if (commandSelector == @selector(insertTab:)) {
//        //Do something against TAB key
//
//    } else if (commandSelector == @selector(cancelOperation:)) {
//        //Do something against Escape key
//    }
//    return YES;
//}
/*
//监听指定按键(与NSTextField相同)
func textView(_ textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
   // insertNewline:  回车键
   // deleteBackward: 回退键
   // insertTab:      tab键
   // moveUp:          上方向键
   // moveDown:        下方向键
   // moveLeft:        左方向键
   // moveRight:       右方向键

    print("\(commandSelector)")
    if commandSelector.description == "insertNewline:" {
       print("按了回车键")
        return true  // 表示代理以及处理键盘事件,不需要系统再进行处理
    }
    // 如果返回false ,则系统自动处理,如果返回true,则系统不做处理
    return false
}
*/
#pragma mark - funtions

- (void)readFile{
    NSString *path = [NSBundle.mainBundle pathForResource:@"appinfo" ofType:@"txt"];
    NSString *content = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    self.textView.string = content;
    
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
    if (self.textField.stringValue.length <= 0
        || self.textFieldTwo.stringValue.length <= 0
        || self.textFieldThree.stringValue.length <= 0) {
        NSAlert *alert = [[NSAlert alloc]initWithTitle:@"提示"
                                               message:@"前缀,类名,父类均不能为空"
                                             btnTitles:@[kTitleKnow]
                                                 style:NSAlertStyleInformational];
        [alert runModal];
        return;
    }
    
    [self setupDefaultWithSender:self.popBtn];
    
//    self.hTextView.string = @"";
//    self.mTextView.string = @"";
    id result = self.textView.string.objValue;
    self.textLabel.stringValue = result ? @"Valid JSON Structure" : @"JSON isn't valid";
    self.textLabel.textColor = result ? NSColor.systemGreenColor : NSColor.redColor;
    if (!result) {
        NSAlert *alert = [[NSAlert alloc]initWithTitle:@"警告"
                                               message:@"Error：Json is invalid"
                                             btnTitles:@[kTitleKnow]
                                                 style:NSAlertStyleInformational];
        [alert beginSheetModalForWindow:NSApp.keyWindow completionHandler:^(NSModalResponse returnCode) {
            DDLog(@"%@", @(returnCode));
        }];
        return;
    }
    
    ESClassInfo *classInfo = [ESClassInfo dealWithJson:result
                                                     handler:^(NSString *hFilename, NSString *mFilename) {
        self.hFilename = hFilename;
        self.mFilename = mFilename;
    }];
    classInfo.langModel = self.langModel;
    [self outputResult:classInfo];
    
}

#pragma mark - Change ESJsonFormat
- (void)outputResult:(ESClassInfo *)classInfo{
    if (ESJsonFormatSetting.defaultSetting.outputToFiles) {
        //选择保存路径
//        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];
        NSOpenPanel *panel = [NSOpenPanel createWithFileTypes:nil allowsMultipleSelection:false];
        if (panel.runModal == NSModalResponseOK) {
            NSString *folderPath = [panel.URLs.firstObject relativePath];
            [classInfo createFileWithFolderPath:folderPath];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
        
    } else {
        if (!NSApplication.isSwift) {
            NNClassInfoModel *classModel = self.dataList.firstObject;
            classModel.className = classInfo.className;
            classModel.hContent = [classInfo classDescWithFirstFile:true];
            
            classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"#import <Foundation/Foundation.h>" withString:self.langModel.staticImports];

            NNClassInfoModel *classModelOne = self.dataList.lastObject;
            classModelOne.className = classInfo.className;
            classModelOne.mContent = [classInfo classDescWithFirstFile:false];
            if (self.valueTypeLab.isSelectable == true) {
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"assign) NSInteger " withString:@"copy) NSString *"];
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"assign) long long " withString:@"copy) NSString *"];
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"assign) CGFloat " withString:@"copy) NSString *"];
            }
            
        } else {
            NNClassInfoModel *classModel = self.dataList.firstObject;
            classModel.className = classInfo.className;
            classModel.hContent = [classInfo classDescWithFirstFile:true];
            
            classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"import Foundation" withString:self.langModel.staticImports];

            if (![classModel.hContent containsString:@"NSObject {"]) {
                NSString *tmp = [NSString stringWithFormat:@"NSObject, %@ {", self.langModel.defaultParentWithUtilityMethods];
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@"NSObject {" withString:tmp];
            }
            if (self.valueTypeLab.isSelectable == true) {
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@": Int = 0" withString:@": String = \"0\""];
                classModel.hContent = [classModel.hContent stringByReplacingOccurrencesOfString:@": Double = 0" withString:@": String = \"0\""];
            }
        }
       
        [self.tableView reloadData];
    }
    
}

- (void)creatFile{
    NNClassInfoModel *classModelH = self.dataList.firstObject;
    NNClassInfoModel *classModelM = self.dataList.lastObject;
    NSString *hContent = classModelH.hContent;
    NSString *mContent = classModelM.mContent;
    
    NSString *folderPath = [NSUserDefaults.standardUserDefaults valueForKey:kFolderPath];
    if (folderPath) {
        [NNFileManager.shared createFileWithFolderPath:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:hContent mContent:mContent];
        [NSWorkspace.sharedWorkspace openFile:folderPath];
        
    } else {
//        NSOpenPanel *panel = [NSOpenPanel openPanelChooseDirs:false];
        NSOpenPanel *panel = [NSOpenPanel createWithFileTypes:nil allowsMultipleSelection:false];
        if (panel.runModal == NSModalResponseOK) {
            folderPath = [panel.URLs.firstObject relativePath];
            [NSUserDefaults.standardUserDefaults setValue:folderPath forKey:kFolderPath];
            DDLog(@"%@",folderPath);
            [NNFileManager.shared createFileWithFolderPath:folderPath hFileName:self.hFilename mFileName:self.mFilename hContent:hContent mContent:mContent];
            [NSWorkspace.sharedWorkspace openFile:folderPath];
        }
    }
}

- (void)updateLanguages{
    NSArray *items = [self.langsDic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [self.popBtn removeAllItems];
    [self.popBtn addItemsWithTitles:items];
}

- (void)setupDefaultWithSender:(NSPopUpButton *)sender{
    NSString *titleOfSelectedItem = sender.titleOfSelectedItem;
    self.langModel = self.langsDic[titleOfSelectedItem];
    //    DDLog(@"titleOfSelectedItem_%@", titleOfSelectedItem);
    
    [NSUserDefaults.standardUserDefaults setObject:titleOfSelectedItem forKey:kDisplayName];
    bool isSwift = [titleOfSelectedItem containsString:@"Swift"] || [titleOfSelectedItem containsString:@"swift"];
    [NSUserDefaults.standardUserDefaults setBool:isSwift forKey:kIsSwift];
    [NSUserDefaults.standardUserDefaults synchronize];
        
    [NSUserDefaults archiveObject:self.langModel forkey:@"langModel"];
    [NSUserDefaults synchronize];
//    id langModel = [NSUserDefaults arcObjectForKey:@"langModel"];
}

#pragma mark - lazy

-(NNTextView *)textView{
    if (!_textView) {
        _textView = ({
            NNTextView *view = [NNTextView create:CGRectZero];
            view.font = [NSFont systemFontOfSize:12];
            view.delegate = self;
            view.string = @"NSScrollView上无法滚动的NSTextView";
            
            view;
        });
    }
    return _textView;
}

-(NNTableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            NNTableView *view = [NNTableView create:CGRectZero];
            view.headerView = nil;
            view.selectionHighlightStyle = NSTableViewSelectionHighlightStyleNone;//行高亮的风格
//            view.columnAutoresizingStyle = NSTableViewUniformColumnAutoresizingStyle;

            [view addTableColumnWithTitles:@[@"colume0",]];
            if ([self conformsToProtocol:@protocol(NSTableViewDataSource)]) view.dataSource = self;
            if ([self conformsToProtocol:@protocol(NSTableViewDelegate)]) view.delegate = self;
            view.enclosingScrollView.hasHorizontalScroller = false;
            view.enclosingScrollView.hasVerticalScroller = false;
            view.enclosingScrollView.autohidesScrollers = true;//自动隐藏滚动条（滚动的时候出现）
            
            view;
        });
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
            NNTextField *view = [NNTextField create:CGRectZero placeholder:@"Class Prefix"];
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
            NNTextField *view = [NNTextField create:CGRectZero placeholder:@"Root Class name"];
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
            NNTextField *view = [NNTextField create:CGRectZero placeholder:@"Supper Class name"];
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

-(HHLabel *)textLabel{
    if (!_textLabel) {
        _textLabel = ({
            HHLabel * view = [[HHLabel alloc]initWithFrame:CGRectZero];
            view.font = [NSFont systemFontOfSize:13];
            view.alignment = NSTextAlignmentCenter;
            
            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            
            view;
        });
    }
    return _textLabel;
}

-(HHLabel *)valueTypeLab{
    if (!_valueTypeLab) {
        _valueTypeLab = ({
            HHLabel * view = [[HHLabel alloc]initWithFrame:CGRectZero];
            view.font = [NSFont systemFontOfSize:13];
            view.textColor = NSColor.grayColor;
            view.alignment = NSTextAlignmentCenter;
            
            view.maximumNumberOfLines = 1;
            view.usesSingleLineMode = true;
            view.stringValue = self.types.firstObject;
            view.mouseDownBlock = ^(HHLabel * _Nonnull sender) {
                sender.selectable = !sender.selectable;
                sender.stringValue = sender.selectable == false ? self.types.firstObject : self.types.lastObject;
                sender.textColor = sender.selectable == false ? NSColor.grayColor : NSColor.redColor;
                [self hanldeJson];
                
            };
            view;
        });
    }
    return _valueTypeLab;
}

-(NSArray *)types{
    if (!_types) {
        _types = @[@"默认类型", @"字符串类型",];
    }
    return _types;
}

-(NSPopUpButton *)popBtn{
    if (!_popBtn) {
        _popBtn = ({
            NSPopUpButton *view = [[NSPopUpButton alloc] initWithFrame:CGRectZero pullsDown:false];
            view.autoenablesItems = true;
            
            NSArray *list = @[@"北京", @"上海", @"广州", @"深圳"];
            [view addItemsWithTitles:list];
            [view addActionHandler:^(NSControl * _Nonnull control) {
                [NSApp.keyWindow makeFirstResponder:nil];
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
                [NSApp.keyWindow makeFirstResponder:nil];
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
                NSData *data = [NSData dataWithContentsOfURL:url];
                
                NSError *error = nil;
                NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                if (error) {
                    [[NSAlert alertWithError:error] runModal];
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

-(NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

@end
