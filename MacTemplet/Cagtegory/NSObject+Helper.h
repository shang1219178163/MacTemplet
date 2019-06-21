//
//  NSObject+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Helper)

/// NSObject->NSData
@property (nonatomic, strong, readonly) NSData * _Nullable jsonData;
/// NSObject->NSString
@property (nonatomic, strong, readonly) NSString * _Nullable jsonString;
/// NSString/NSData->NSObject/NSDiction/NSArray
@property (nonatomic, strong, readonly) id _Nullable objValue;
/// NSString/NSData->NSDictionary
@property (nonatomic, strong, readonly) NSDictionary * _Nullable dictValue;

@end

NS_ASSUME_NONNULL_END
