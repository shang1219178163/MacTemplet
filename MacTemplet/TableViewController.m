//
//  TableViewController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)loadView{
    //NSMakeRect(0, 0, 250, 150)
    NSWindow *window = NSApplication.sharedApplication.mainWindow;
    self.view = [[NSView alloc]initWithFrame:window.frame];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.wantsLayer = YES;
    self.view.layer.backgroundColor = NSColor.whiteColor.CGColor;
    
}

@end
