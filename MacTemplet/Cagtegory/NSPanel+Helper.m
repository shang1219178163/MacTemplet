//
//  NSPanel+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSPanel+Helper.h"

@implementation NSPanel (Helper)

+(__kindof NSOpenPanel *)openPanelChooseFileTypes:(NSArray *)fileTypes{
    assert([self isSubclassOfClass:NSOpenPanel.class]);
    
    NSOpenPanel *panel = NSOpenPanel.openPanel;
    panel.canChooseFiles = true;
    panel.canChooseDirectories = false;
    panel.allowsMultipleSelection = true;
    panel.allowedFileTypes = fileTypes;
    NSString * path = [NSString stringWithFormat:@"/Users/%@/Downloads", NSProcessInfo.processInfo.userName];
    panel.directoryURL = [NSURL fileURLWithPath:path];
//    [panel runModal];
//    if (panel.runModal == NSModalResponseOK) {
//        NSLog(@"%@", panel.URLs);
//    }
    return panel;
}

+(__kindof NSOpenPanel *)openPanelChooseDirs:(BOOL)isMultipleSelection{
    assert([self isSubclassOfClass:NSOpenPanel.class]);
    
    NSOpenPanel *panel = NSOpenPanel.openPanel;
    panel.canChooseFiles = false;
    panel.canChooseDirectories = true;
    panel.allowsMultipleSelection = isMultipleSelection;
    NSString * path = [NSString stringWithFormat:@"/Users/%@/Downloads", NSProcessInfo.processInfo.userName];
    panel.directoryURL = [NSURL fileURLWithPath:path];
    return panel;
}

+(void)openPanelFileTypes:(NSArray *)fileTypes{    
    NSOpenPanel *panel = [NSOpenPanel openPanelChooseFileTypes:fileTypes];
    [panel runModal];
    if (panel.runModal == NSModalResponseOK) {
        NSLog(@"%@", panel.URLs);
    }
}

@end
