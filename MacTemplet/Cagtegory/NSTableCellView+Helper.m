

//
//  NSTableCellView+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTableCellView+Helper.h"

@implementation NSTableCellView (Helper)

+(instancetype)viewWithTableView:(NSTableView *)tableView identifier:(NSString *)identifier owner:(nullable id)owner{
    NSTableCellView *cell = [tableView makeViewWithIdentifier:identifier owner:owner];
    if (!cell) {
        cell = [[self alloc]init];
        cell.identifier = identifier;
        cell.wantsLayer = YES;

    }
    return cell;
}


@end
