
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


@end
