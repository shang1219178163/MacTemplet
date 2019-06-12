//
//  NSTableCellView+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/12.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTableCellView (Helper)

+(instancetype)viewWithTableView:(NSTableView *)tableView identifier:(NSString *)identifier owner:(nullable id)owner;

@end

NS_ASSUME_NONNULL_END
