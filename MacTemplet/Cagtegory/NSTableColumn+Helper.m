


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
    NSTableColumn *column = [[self alloc] initWithIdentifier:identifier];
    column.title = title;
    column.minWidth = 40;
    column.maxWidth = CGFLOAT_MAX;
    column.headerToolTip = column.title;
    column.resizingMask = NSTableColumnAutoresizingMask;
    column.headerCell.alignment = NSTextAlignmentCenter;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:column.identifier
                                                           ascending:false
                                                          comparator:^(id obj1, id obj2) {
                                                               if (obj1 < obj2) {
                                                                   return NSOrderedAscending;
                                                               }
                                                               if (obj1 > obj2) {
                                                                   return NSOrderedDescending;
                                                               }
                                                               return NSOrderedSame;
                                                           }];
    column.sortDescriptorPrototype = sort;
    return column;
}

@end
