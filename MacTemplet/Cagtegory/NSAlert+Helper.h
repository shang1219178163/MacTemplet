//
//  NSAlert+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/19.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAlert (Helper)

+(void)showAlertWithError:(NSError *)error;

+(instancetype)createAlertTitle:(NSString *)title msg:(NSString *)msg btnTitles:(NSArray<NSString *> *)btnTitles;

- (void)beginSheetModalHandler:(void (^ __nullable)(NSModalResponse returnCode))handler;

@end

NS_ASSUME_NONNULL_END
