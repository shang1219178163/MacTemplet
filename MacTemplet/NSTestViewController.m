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

#import <CocoaExpand-Swift.h>

@interface NSTestViewController ()


@end

@implementation NSTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.lightGreen.CGColor;
    
    NSClickGestureRecognizer *click = [[NSClickGestureRecognizer alloc]init];
    [self.view addGestureRecognizer:click];
    
    [click addAction:^(NSGestureRecognizer * reco) {
        DDLog(@"%@", @"1111");
    }];

//    [click addAction:^{
////        NSLog(@"%@", click);
//        DDLog(@"%@", @"1111");
//    }];
        
    
}


- (void)viewWillAppear{
    [super viewWillAppear];
    
//    Class cls = NSClassFromString(@"AuthorInfoController");
//    DDLog(cls);
}



@end
