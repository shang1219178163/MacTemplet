
//
//  NSAlert+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSAlert+Helper.h"

@implementation NSAlert (Helper)

+(void)showAlertWithError:(NSError *)error{
    NSAlert *alert = [NSAlert alertWithError:error];
    [alert runModal];
}

+(instancetype)createAlertTitle:(NSString *)title msg:(NSString *)msg btnTitles:(NSArray<NSString *> *)btnTitles{
    NSAlert *alert = [[NSAlert alloc]init];
    alert.messageText = title;
    alert.informativeText = msg;
    alert.alertStyle = NSAlertStyleInformational;
    for (NSString * btnTitle in btnTitles) {
        [alert addButtonWithTitle:btnTitle];
    }
//    [alert beginSheetModalForWindow:NSApplication.sharedApplication.mainWindow completionHandler:^(NSModalResponse returnCode) {
//        if (returnCode == NSModalResponseOK){
//            NSLog(@"(returnCode == NSOKButton)");
//        }else if (returnCode == NSModalResponseCancel){
//            NSLog(@"(returnCode == NSCancelButton)");
//        }else if(returnCode == NSAlertFirstButtonReturn){
//            NSLog(@"if (returnCode == NSAlertFirstButtonReturn)");
//        }else if (returnCode == NSAlertSecondButtonReturn){
//            NSLog(@"else if (returnCode == NSAlertSecondButtonReturn)");
//        }else if (returnCode == NSAlertThirdButtonReturn){
//            NSLog(@"else if (returnCode == NSAlertThirdButtonReturn)");
//        }else{
//            NSLog(@"All Other return code %ld",(long)returnCode);
//        }
//    }];
    return alert;
}

- (void)beginSheetModalHandler:(void (^ __nullable)(NSModalResponse returnCode))handler{
    assert(NSApplication.sharedApplication.mainWindow);
    [self beginSheetModalForWindow:NSApplication.sharedApplication.mainWindow completionHandler:handler];
    
}

@end
