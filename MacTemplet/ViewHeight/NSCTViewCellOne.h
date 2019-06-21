//
//  NSCTViewCellOne.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NNTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSCTViewCellOne : NSCollectionViewItem

@property (nonatomic, strong) NSImageView *imgView;
//@property (nonatomic, strong) NNTextField *textField;
@property (nonatomic, strong) NNTextField *label;

@end

NS_ASSUME_NONNULL_END
