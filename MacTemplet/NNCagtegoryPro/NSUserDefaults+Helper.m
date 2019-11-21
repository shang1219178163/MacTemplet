//
//  NSUserDefaults+Helper.m
//  
//
//  Created by BIN on 2018/3/16.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import "NSUserDefaults+Helper.h"

//#import <objc/runtime.h>

@implementation NSUserDefaults (Helper)

+ (BOOL)isSupport:(nullable id)value{
    //@[@"NSData", @"NSString", @"NSNumber", @"NSDate", @"NSArray", @"NSDictionary"];
    BOOL isData = [value isKindOfClass: NSData.class];
    BOOL isDate = [value isKindOfClass: NSDate.class];
    BOOL isString = [value isKindOfClass: NSString.class];
    BOOL isNumber = [value isKindOfClass: NSNumber.class];
    BOOL isArray = [value isKindOfClass: NSArray.class];
    BOOL isDictionary = [value isKindOfClass: NSDictionary.class];
    
    if (isData || isDate || isString || isNumber || isArray || isDictionary) {
        return true;
    }
    return false;
}

+ (void)setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync{
    if (sync){
        [NSUbiquitousKeyValueStore.defaultStore setValue:value forKey:key];
    }
    [self setObject:value forKey:key];
}

//保存自定义对象
+ (void)setObject:(id)value forKey:(NSString *)key{
    if ([value isKindOfClass: NSData.class]) {
        [self setArcObject:value forKey:key];
    } else {
        [self.standardUserDefaults setObject:value forKey:key];
    }
}

+ (id)objectForKey:(NSString *)key iCloudSync:(BOOL)sync{
    if (sync) {
        id value = [NSUbiquitousKeyValueStore.defaultStore valueForKey:key];
        [self.standardUserDefaults setValue:value forKey:key];
        [self.standardUserDefaults synchronize];
        return value;
    }
    return [self objectForKey:key];
}

//解档自定义对象
+ (id)objectForKey:(NSString *)key{
    id value = [self.standardUserDefaults objectForKey:key];
//    Class clz = [obj isKindOfClass: NSData.class] ? NSData.class : NSObject.class;
    if ([value isKindOfClass: NSData.class]) {
        value = [self arcObjectForKey:key];
    }
    return value;
}

+ (void)synchronizeAndCloudSync:(BOOL)sync{
    if (sync) {
        [NSUbiquitousKeyValueStore.defaultStore synchronize];
    }
    [self.standardUserDefaults synchronize];
}

+ (void)synchronize{
    [self synchronizeAndCloudSync:NO];
    
//    NSString *path = NSHomeDirectory();
    //    DDLog(@"\n%@",path);
}

+ (void)setArcObject:(id)value forKey:(NSString *)key{
    if (!value) {
        return;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:value];
    [self.standardUserDefaults setObject:data forKey:key];
}

+ (id)arcObjectForKey:(NSString *)key{
    id value = [NSUserDefaults.standardUserDefaults objectForKey:key];
    if (!value) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:value];
}

@end
