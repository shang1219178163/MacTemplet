//
//  AppDelegate.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/8.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (nonatomic,strong) NSStatusItem *statusItem; //必须应用、且强引用，否则不会显示。

@end

