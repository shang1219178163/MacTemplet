//
//  HomeViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "HomeViewController.h"
#import "NNTextField.h"

#import "OneWindowController.h"
#import "NNDialogWindowController.h"

#import <CocoaExpand-Swift.h>

static NSString *kDefaultTabIndex = @"kDefaultTabIndex";

@interface HomeViewController ()<NSTabViewDelegate>

@property (nonatomic, strong) NSTabView *tabView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [self.view addSubview:self.tabView];
    
//    [self.view getViewLayer];
}

-(void)viewWillAppear{
    [super viewWillAppear];
    
    NSArray *list = @[@[@"JsonToModelController", @"json转模型", ],
                      @[@"ProppertyLazyController", @"属性Lazy",],
                      @[@"BatchVCCreateController", @"类文件批量生成",],
                      @[@"AuthorInfoController", @"其他",],
//                      @[@"NSTestViewController", @"测试模块",],
//                      @[@"TmpViewController", @"Swift模块",],
//                      @[@"NSStackViewController", @"StackView",],
//                      @[@"MapViewController", @"MapView",],
                      @[@"FileController", @"File处理",],
//                      @[@"NNTableViewController", @"NNTable",],
                      
                      ];
    [self.tabView addItems:list];

    if ([NSUserDefaults.standardUserDefaults objectForKey:kDefaultTabIndex]) {
        NSInteger idx = [[NSUserDefaults.standardUserDefaults objectForKey:kDefaultTabIndex]integerValue];
        idx = idx < list.count ? idx : 0;
        [self.tabView selectTabViewItemAtIndex:idx];
    }

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
    [NSUserDefaults.standardUserDefaults setObject: NSStringFromRect(NSApp.mainWindow.frame) forKey:kMainWindowFrame];
    [NSUserDefaults.standardUserDefaults synchronize];
}


#pragma mark -NSTabViewDelegate

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem{
    NSInteger index = [tabView.tabViewItems indexOfObject:tabViewItem];
//    DDLog(@"index_%@_%@",@(index), tabViewItem.view);
    if (index == 0) {
        return;
    }
    [NSUserDefaults.standardUserDefaults setObject:@(index) forKey:kDefaultTabIndex];
    [NSUserDefaults.standardUserDefaults synchronize];
}

#pragma mark -lazy

-(NSTabView *)tabView{
    if (!_tabView) {
        _tabView = ({
            NSTabView * view = [NSTabView create:CGRectZero];
            view.delegate = self;

            view;
        });
    }
    return _tabView;
}

@end
