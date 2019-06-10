//
//  NSString+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Helper)

/// NSDictionary/NSArray/NSError
@property (nonatomic, strong, readonly) id objc;
@property (nonatomic, strong, readonly) NSDictionary * dict;
@property (nonatomic, strong, readonly) NSArray * array;

@end

NS_ASSUME_NONNULL_END
