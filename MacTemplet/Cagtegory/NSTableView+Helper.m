
//
//  NSTableView+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTableView+Helper.h"
#import "NSTableColumn+Helper.h"

@implementation NSTableView (Helper)

- (void)addTableColumnTitles:(NSArray<NSString *> *)tableColumnTitles {
    [tableColumnTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         NSTableColumn * column = [NSTableColumn createWithIdentifier:obj title:obj];
         [self addTableColumn:column];
     }];
}

@end
