//
//  main.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

int main(int argc, const char * argv[]) {
    NSApplication *app = NSApplication.sharedApplication;
    id delegate = [[AppDelegate alloc] init];
    app.delegate = delegate;
    return NSApplicationMain(argc, argv);
}
