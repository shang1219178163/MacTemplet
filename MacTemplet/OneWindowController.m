//
//  OneWindowController.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "OneWindowController.h"
#import "TableViewController.h"

@interface OneWindowController ()

@property (nonatomic, strong) TableViewController *tableController;

@end

@implementation OneWindowController

- (instancetype)initWithWindow:(NSWindow *)window{
    self = [super initWithWindow:window];
    if (self) {
        self.contentViewController = self.tableController;
        self.window.contentView = self.contentViewController.view;
    }
    return self;
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
}

-(TableViewController *)tableController{
    if (!_tableController) {
        _tableController = [[TableViewController alloc]init];
    }
    return _tableController;
}

@end
