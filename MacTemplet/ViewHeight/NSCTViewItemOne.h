//
//  NSCTViewItemOne.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCTViewItemOne : NSView

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSCollectionViewItemHighlightState highlightState;

@end

NS_ASSUME_NONNULL_END
