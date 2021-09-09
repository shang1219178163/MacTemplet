//
//  HomeViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HomeViewController.h"
#import "NNTextField.h"

#import <SwiftExpand-Swift.h>

static NSString *kDefaultTabIndex = @"kDefaultTabIndex";

@interface HomeViewController ()<NSTabViewDelegate>

@property (nonatomic, strong) NSTabView *tabView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    [self setupUI];
}

-(void)viewWillAppear{
    [super viewWillAppear];
    
}

- (void)viewDidLayout{
    [super viewDidLayout];
    
    [self.tabView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kY_GAP);
        make.left.equalTo(self.view).offset(kX_GAP);
        make.right.equalTo(self.view).offset(-kX_GAP);
        make.bottom.equalTo(self.view).offset(-kY_GAP);
    }];
    
    // 保存窗口尺寸
    [NSUserDefaults.standardUserDefaults setObject: NSStringFromRect(NSApp.keyWindow.frame) forKey:kMainWindowFrame];
    [NSUserDefaults.standardUserDefaults synchronize];
}


#pragma mark -NSTabViewDelegate

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem{
    NSInteger index = [tabView.tabViewItems indexOfObject:tabViewItem];
//    DDLog(@"index_%@_%@",@(index), tabViewItem.view);
//    if (index == 0) {
//        return;
//    }
    [NSUserDefaults.standardUserDefaults setObject:@(index) forKey:kDefaultTabIndex];
    [NSUserDefaults.standardUserDefaults synchronize];
}

#pragma mark -funtions
- (void)setupUI{
    NSArray *list = @[@[@"JsonToModelController", @"JSON转模型", ],
                      @[@"ProppertyLazyController", @"属性Lazy",],
                      @[@"NNBatchClassCreateController", @"类文件批量创建",],
                      @[@"ProppertyChainController", @"属性转链式",],
                      @[@"ProppertyChainSwiftController", @"Swift属性转链式",],
//                      @[@"FlutterIconDataController", @"FlutterIconData",],
                      @[@"FlutterWidgetToExtController", @"Widget转扩展",],
            
                      @[@"DragFileController", @"文件拖拽",],

                      @[@"AuthorInfoController", @"Author",],
////                      @[@"NNButtonStyleController", @"NSButon研究",],
////                      @[@"NNButtonStudyController", @"NNButton封装",],
////                      @[@"NNLabelStudyController", @"NNLabel封装",],
                      @[@"TmpViewController", @"Tmp模块",],
//                      @[@"UImageBatchCreateContoller", @" 字符串转 UImage",],
                      @[@"OtherConvertController", @"字符串加工",],
                      @[@"UImageBatchCreateByAssetContoller", @"UImage转化",],
                      
//                      @[@"OthersViewController", @"Others",],
//                      @[@"NNSplitViewController", @"SplitView",],
//                                            
//                      @[@"YYModelSwiftController", @"YYModelSwift",],
////                    @[@"CollectionViewController", @"CollectionView模块",],
////                      @[@"NSTestViewController", @"测试模块",],
//
//                      @[@"NSAlertStudyController", @"NSAlertStudy",],
////                      @[@"NSOpenPanelStudyController", @"NSOpenPanelStud",],
////                      @[@"NSStackViewController", @"StackView",],
//                      @[@"MapViewController", @"MapView",],
////                      @[@"FileController", @"File处理",],
////                      @[@"NNTableViewController", @"NNTable",],
                      ];
    [self.tabView addItems:list];

    if ([NSUserDefaults.standardUserDefaults objectForKey:kDefaultTabIndex]) {
        NSInteger idx = [[NSUserDefaults.standardUserDefaults objectForKey:kDefaultTabIndex]integerValue];
        idx = idx < list.count ? idx : 0;
        [self.tabView selectTabViewItemAtIndex:idx];
    }
    [self.view addSubview:self.tabView];
    
    DDLog(@"name: %@", self.vcName);
//    NSNumberFormatter *fmt =
}

#pragma mark -lazy

-(NSTabView *)tabView{
    if (!_tabView) {
        _tabView = ({
            NSTabView * view = [NSTabView new];
            view.tabViewBorderType = NSNoTabsNoBorder;
            view.tabViewType = NSTabViewBorderTypeNone;
            view.delegate = self;

            view;
        });
    }
    return _tabView;
}

@end
