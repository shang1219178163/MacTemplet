//
//  TableViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "TableViewController.h"
#import "NNTableView.h"
#import "NNTableRowView.h"
#import "NNTextField.h"


@interface TableViewController ()<NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NNTableView *tableView;
@property (nonatomic, strong) NSArray *list;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
//    self.view.layer.backgroundColor = NSColor.redColor.CGColor;
    
    [self setupTableView];
    [self.view addSubview:self.tableView.enclosingScrollView];
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    [self.tableView.enclosingScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.tableView.enclosingScrollView.superview);
    }];
}

- (void)viewWillAppear{
    [super viewWillAppear];
    
    DDLog(@"111");
 
}

#pragma mark - NSTableViewDelegate,NSTableViewDataSource

//返回行数
-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    return self.list.count;
}

-(CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row{
    return 60;
}
//// 使用默认cell显示数据
//-(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
//    NSInteger item = [tableView.tableColumns indexOfObject:tableColumn];
//    NSArray * array = self.list[row];
//    return array[item];
//}
//// 使用自定义cell显示数据
-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    NSInteger item = [tableView.tableColumns indexOfObject:tableColumn];
    NSArray * array = self.list[row];
    
    //获取表格列的标识符
    NSString *columnID = tableColumn.identifier;
    DDLog(@"columnID : %@ ,row : %ld",columnID,row);
    
    static NSString *identifier = @"one";
    NSTableCellView *cell = [NSTableCellView makeViewWithTableView:tableView identifier:identifier owner:self];

//    cell.layer.backgroundColor = NSColor.greenColor.CGColor;

//    cell.layer.backgroundColor = NSColor.yellowColor.CGColor;
//    cell.imageView.image = [NSImage imageNamed:@"swift"];
    cell.textField.stringValue = [NSString stringWithFormat:@"cell %ld",(long)row];
    cell.textField.stringValue = [NSString stringWithFormat:@"%@",array[item]];
    
//    NSTextField * textField = [NSTextField create:cell.bounds text:array[item] placeholder:@""];
    NNTextField * textField = [NNTextField create:cell.bounds placeholder:@""];
    textField.alignment = NSTextAlignmentCenter;
    textField.isTextAlignmentVerticalCenter = true;
    textField.stringValue = array[item];

    [cell addSubview:textField];
    return cell;
}

//设置每行容器视图
- (nullable NSTableRowView *)tableView:(NSTableView *)tableView rowViewForRow:(NSInteger)row{
    NNTableRowView * rowView = [[NNTableRowView alloc]init];
    rowView.backgroundColor = NSColor.yellowColor;
    return rowView;
}

#pragma mark - 是否可以选中单元格
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
-(void)tableViewSelectionDidChange:(nonnull NSNotification *)notification{
//    NSTableView *tableView = notification.object;
//    DDLog(@"didSelect：%@",notification);
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

#pragma mark -funtions

-(void)setupTableView{
    NSArray * columns = @[@"columeOne", @"columeTwo", @"columeThree",];
    columns = self.list.firstObject;
    [columns enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTableColumn * column = [NSTableColumn createWithIdentifier:obj title:obj];
        [self.tableView addTableColumn:column];
    }];

}

#pragma mark -lazy
-(NNTableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            NNTableView *view = [NNTableView create:CGRectZero];
            view.delegate = self;
            view.dataSource = self;
            view;
        });
    }
    return _tableView;
}

- (NSArray *)list{
    if (!_list) {
        _list = @[
                    @[@"名称",@"总数",@"剩余",@"IP",@"状态",@"状态1",@"状态2",@"状态3",@"状态4"],
                    @[@"ces1",@0,@0,@"3.4.5.6",@"027641081087",@"1",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces2",@0,@0,@"3.4.5.6",@"027641081087",@"2",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces3",@0,@0,@"3.4.5.6",@"027641081087",@"3",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces4",@0,@0,@"3.4.5.6",@"027641081087",@"4",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces5",@0,@0,@"3.4.5.6",@"027641081087",@"5",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces6",@"",@0,@"3.4.5.6",@"027641081087",@"6",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces7",@0,@0,@"3.4.5.6",@"027641081087",@"7",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces8",@0,@0,@"3.4.5.6",@"027641081087",@"8",@0,@"3.4.5.6",@"027641081087"],
                    @[@"ces9",@0,@0,@"3.4.5.6",@"027641081087",@"9",@0,@"3.4.5.6",@"027641081087"],
                    ];
    }
    return _list;
}


@end
