//
//  TableViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "TableViewController.h"
#import "NNTableView.h"


@interface TableViewController ()<NSTableViewDelegate, NSTableViewDataSource>

@property (nonatomic, strong) NNTableView *tableView;

@property (nonatomic, strong) NSArray *list;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
//    self.view.layer.backgroundColor = NSColor.redColor.CGColor;
    
    DDLog(@"%@",self.tableView.enclosingScrollView);
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
    NSLog(@"columnID : %@ ,row : %ld",columnID,row);
    
    static NSString *cellIdentifier = @"one";
    NSTableCellView *cell = [NSTableCellView viewWithTableView:tableView identifier:cellIdentifier owner:self];
//    NSTableCellView *cell = [tableView makeViewWithIdentifier:cellIdentifier owner:self];
//    if (!cell) {
//        cell = [[NSTableCellView alloc]init];
//        cell.identifier = cellIdentifier;
//        cell.wantsLayer = YES;
//    }
    
    cell.layer.backgroundColor = NSColor.yellowColor.CGColor;
    
    //    cell.imageView.image = [NSImage imageNamed:@"swift"];
    cell.textField.stringValue = [NSString stringWithFormat:@"cell %ld",(long)row];
    cell.textField.stringValue = [NSString stringWithFormat:@"%@",array[item]];
    
<<<<<<< HEAD:MacTemplet/Controller/TableViewController.m
//    NSTextField * textField = [NSTextField createTextFieldRect:cell.bounds text:array[item] placeholder:@""];
    NNTextField * textField = [NNTextField createTextFieldRect:cell.bounds placeholder:@""];
    textField.alignment = NSTextAlignmentCenter;
    textField.isTextAlignmentVerticalCenter = true;
    textField.stringValue = array[item];

=======
    NSTextField * textField = [NSView createTextFieldRect:cell.bounds text:array[item] placeholder:@""];
>>>>>>> parent of cf5b59e... 需求模块:MacTemplet/TableViewController.m
    [cell addSubview:textField];
    return cell;
}

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

#pragma mark -funtions

-(void)setupTableView{
    
    NSArray * colums = @[@"columeOne", @"columeTwo", @"columeThree",];
    colums = self.list.firstObject;
    [colums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSTableColumn * colum = [NSTableColumn createWithIdentifier:obj title:obj];
        colum.minWidth = 40;
        colum.maxWidth = 200;
        [self.tableView addTableColumn:colum];
    }];

}

#pragma mark -lazy

-(NNTableView *)tableView{
    if (!_tableView) {
        _tableView = ({
            NNTableView *view = [[NNTableView alloc] init];
            view.focusRingType = NSFocusRingTypeNone;//tableview获得焦点时的风格
            view.selectionHighlightStyle = NSTableViewSelectionHighlightStyleRegular;//行高亮的风格
            view.backgroundColor = NSColor.orangeColor;
            view.usesAlternatingRowBackgroundColors = YES; //背景颜色的交替，一行白色，一行灰色。设置后，原来设置的 backgroundColor 就无效了。
            view.gridColor = NSColor.redColor;
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
