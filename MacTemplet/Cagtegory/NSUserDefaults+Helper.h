//
//  NSUserDefaults+Helper.h
//  
//
//  Created by BIN on 2018/3/16.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Helper)

@property (class, nonatomic, readonly) NSArray *typeList;

+ (void)setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync;

+ (void)setObject:(id)value forKey:(NSString *)key;

+ (id)objectForKey:(NSString *)key iCloudSync:(BOOL)sync;

+ (id)objectForKey:(NSString *)key;

+ (void)synchronizeAndCloudSync:(BOOL)sync;

+ (void)synchronize;
    
@end
