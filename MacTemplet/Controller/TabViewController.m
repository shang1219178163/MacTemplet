//
//  TabViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "TabViewController.h"
#import "NNTextField.h"

#import "OneWindowController.h"
#import "BNDialogWindowController.h"

@interface TabViewController ()<NSTabViewDelegate>

@property (nonatomic, strong) NSTabView * tabView;

@end

@implementation TabViewController

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
                      @[@"AuthorInfoController", @"其他",],
                      @[@"ThirdViewController", @"Third",],
//                      @[@"FirstViewController", @"First",],
                      
                      ];
    [self.tabView addItems:list];
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
    NSInteger item = [self.tabView.tabViewItems indexOfObject:tabViewItem];
    DDLog(@"index_%@_%@",@(item), tabViewItem.view);
    
}

#pragma mark -lazy

-(NSTabView *)tabView{
    if (!_tabView) {
        _tabView = ({
            NSTabView * view = [NSTabView createTabViewRect:CGRectZero];
            view.delegate = self;

            view;
        });
    }
    return _tabView;
}

@end
