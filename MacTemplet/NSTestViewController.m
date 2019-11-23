//
//  NSTestViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTestViewController.h"
#import "NNHeaderView.h"
#import "NoodleLineNumberView.h"
#import "NNPropertyInfoModel.h"

@interface NSTestViewController ()



@end

@implementation NSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    
#if DEBUG
    DDLog(@"NSTestViewController_测试模式");
    
#else
    DDLog(@"NSTestViewController_release模式");
#endif
    
    NSClickGestureRecognizer * click = [[NSClickGestureRecognizer alloc]init];
    [self.view addGestureRecognizer:click];
    [click addAction:^(NSGestureRecognizer * reco) {
        DDLog(@"%@", reco);
    }];
    
}


- (void)viewWillAppear{
    [super viewWillAppear];
    
//    Class myCls = NSClassFromString(@"AuthorInfoController");
//    NSString *str = NSStringFromClass(myCls);
//
//    if (str.length) {
//        NSLog(@"这个类存在");
//
//    }else{
//        NSLog(@"这个类不存在");
//    }
//    bool isExsit = [NSFileManager isExistFileWithName:@"AuthorInfoController" isSwift:true];
    
    Class cls = NSClassFromString(@"AuthorInfoController");
    Class clsOne = NSClassFromString(@"AuthorInfoController1");
    Class clsTwo = NSClassFromString(@"MacTemplet.TmpViewController");
    Class clsThree = NSClassFromString(@"TmpViewController");
//    DDLog(cls, clsOne, clsTwo, clsThree);
}



@end
