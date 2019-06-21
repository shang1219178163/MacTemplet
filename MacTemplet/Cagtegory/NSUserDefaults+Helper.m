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

+ (NSArray *)typeList{
    return @[@"NSData", @"NSString", @"NSNumber", @"NSDate", @"NSArray", @"NSDictionary"];
}

+ (void)setObject:(id)value forKey:(NSString *)key iCloudSync:(BOOL)sync{
    if (sync){
        [NSUbiquitousKeyValueStore.defaultStore setValue:value forKey:key];
    }
    [self setObject:value forKey:key];
    
}

+ (void)setObject:(id)value forKey:(NSString *)key{
    //添加数组支持
    NSArray * array = self.typeList;
    if (![array containsObject:NSStringFromClass([value class])]) {
        value = [NSKeyedArchiver archivedDataWithRootObject:value requiringSecureCoding:false error:nil];//保存自定义对象
    }
    [self.standardUserDefaults setObject:value forKey:key];
    
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

+ (id)objectForKey:(NSString *)key{
    id obj = [self.standardUserDefaults objectForKey:key];
//    Class clz = [obj isKindOfClass: NSData.class] ? NSData.class : NSObject.class;
    if ([obj isKindOfClass: NSData.class] ) {
        obj = [NSKeyedUnarchiver unarchivedObjectOfClass:NSData.class fromData:obj error:nil];//解档自定义对象
    }
    return obj;
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


@end
