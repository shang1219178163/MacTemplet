//
//  NSTableCellViewTen.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/25.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "HHLabel.h"

@class NNTextView;

NS_ASSUME_NONNULL_BEGIN

@interface NSTableCellViewTen : NSTableCellView

@property (nonatomic, strong) NSButton *checkBox;
@property (nonatomic, strong) HHLabel *textLabel;
@property (nonatomic, strong) NNTextView *textView;

@end

NS_ASSUME_NONNULL_END
