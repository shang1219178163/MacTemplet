//
//  MainViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@property (nonatomic, strong) NSArray *btnList;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    NSArray *list = @[@[@"FirstViewController", @"首页", ],
                      @[@"SecondViewController", @"圈子",],
                      @[@"ThirdViewController", @"消息",],
                      
                      ];
    [self.tabView addItems:list];
        
    if (@available(macOS 10.12, *)) {
        self.tabView.tabViewBorderType = NSTabViewBorderTypeBezel;//边框样式：bezel类型边框
    }
    
    self.selectedTabViewItemIndex = 0;
}


#pragma mark -NSTabViewDelegate

- (void)tabView:(NSTabView *)tabView didSelectTabViewItem:(nullable NSTabViewItem *)tabViewItem{
    [super tabView:tabView didSelectTabViewItem:tabViewItem];
    
    NSInteger item = [self.tabViewItems indexOfObject:tabViewItem];
    DDLog(@"index_%@",@(item));
}

#pragma mark -funtions

//- (void)addItems:(NSArray<NSArray *> *)items{
//    [items enumerateObjectsUsingBlock:^(NSArray * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        NSViewController * controller = [[NSClassFromString(obj.firstObject) alloc] init];
//        controller.title = controller.title ? : (obj[1] ? : @"");
//
//        NSTabViewItem * item = [NSTabViewItem tabViewItemWithViewController:controller];
//        item.view = controller.view;
//        [self addTabViewItem:item];
//    }];
//}


@end
