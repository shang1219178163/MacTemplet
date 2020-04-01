//
//  ThirdViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "ThirdViewController.h"

#import <CocoaExpand-Swift.h>

@interface ThirdViewController ()


@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.lightGreen.CGColor;

}

- (void)viewWillAppear{
    [super viewWillAppear];
    
    [self showDialogView];
}

#pragma mark -lazy

- (void)showDialogView{
    CGSize size = CGSizeMake(NSApp.mainWindow.minSize.width*0.5, NSApp.mainWindow.minSize.height*0.5);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    NSWindow *window = [NSWindow createWithCtrlName: @"DialogViewController" size:size];
    
    NSViewController *controller = [[NSClassFromString(@"DialogViewController") alloc]init];
    controller.preferredContentSize = size;
    NSWindow *window = [NSWindow create:rect controller:controller];

//    window.contentViewController.currentWindow = window;
    [NSApp.mainWindow beginSheet:window completionHandler:^(NSModalResponse returnCode) {
        DDLog(@"returnCode_%@", @(returnCode));
    }];
    
}


@end
