//
//  NSObject+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Helper)<NSSecureCoding>

/// NSObject->NSData
@property (nonatomic, strong, readonly) NSData * _Nullable jsonData;
/// NSObject->NSString
@property (nonatomic, strong, readonly) NSString * _Nullable jsonString;
/// NSString/NSData->NSObject/NSDiction/NSArray
@property (nonatomic, strong, readonly) id _Nullable objValue;
/// NSString/NSData->NSDictionary
@property (nonatomic, strong, readonly) NSDictionary * _Nullable dictValue;


//为 NSObject 扩展 NSCoding 协议里的两个方法, 用来便捷实现复杂对象的归档与反归档
-(void)encodeWithCoder:(NSCoder *)aCoder;

-(instancetype)initWithCoder:(NSCoder *)aDecoder;
//KVC
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

-(id)valueForUndefinedKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
