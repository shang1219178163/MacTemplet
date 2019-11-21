//
//  NSUserDefaults+Helper.h
//  
//
//  Created by BIN on 2018/3/16.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Helper)

+ (BOOL)isSupport:(nullable id)value;

+ (void)setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

//保存自定义对象
+ (void)setObject:(id)value forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

//解档自定义对象
+ (id)objectForKey:(NSString *)key;

+ (void)synchronizeAndCloudSync:(BOOL)sync;

+ (void)synchronize;

+ (void)setArcObject:(id)value forKey:(NSString *)key;

+ (id)arcObjectForKey:(NSString *)key;

@end
