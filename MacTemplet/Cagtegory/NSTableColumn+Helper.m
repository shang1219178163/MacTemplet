


//
//  NSTableColumn+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/11.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTableColumn+Helper.h"

@implementation NSTableColumn (Helper)

+ (instancetype)createWithIdentifier:(NSUserInterfaceItemIdentifier)identifier title:(NSString *)title{
    NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:identifier];
    column.title = title;
    return column;
}

@end
