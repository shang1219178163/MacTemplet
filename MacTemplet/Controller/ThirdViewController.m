//
//  ThirdViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "ThirdViewController.h"
#import "BNDialogWindowController.h"

@interface ThirdViewController ()



@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.layer.backgroundColor = NSColor.greenColor.CGColor;

}

- (void)viewWillAppear{
    [super viewWillAppear];
    
    [self showDialogView];
}

#pragma mark -lazy

- (void)showDialogView{
    CGSize windowSize = CGSizeMake(kScreenHeight*0.2, kScreenHeight*0.2);
    
    NSString * controllerName = @"DialogViewController";
    NSViewController * controller = [[NSClassFromString(controllerName) alloc] init];
    controller.view.frame = CGRectMake(0, 0, NSApp.mainWindow.minSize.width*0.5, NSApp.mainWindow.minSize.height*0.5);
    
    
    NSWindow * window = [NSWindow createWithSize:windowSize title:@"777"];
    window.contentViewController = controller;
    controller.currentWindow = window;
    [NSApp.mainWindow beginSheet:window completionHandler:^(NSModalResponse returnCode) {
        DDLog(@"returnCode_%@", @(returnCode));
    }];
    
}


@end
