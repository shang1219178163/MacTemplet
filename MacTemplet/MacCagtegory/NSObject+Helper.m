//
//  NSObject+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSObject+Helper.h"

@implementation NSObject (Helper)

-(NSData *)jsonData{
    assert([self isKindOfClass: NSData.class] || [self isKindOfClass: NSString.class] || [self isKindOfClass: NSDictionary.class] || [self isKindOfClass: NSArray.class]);

    id obj = self;
    
    NSData *data = nil;
    if ([obj isKindOfClass: NSData.class]) {
        data = obj;
        
    } else if ([obj isKindOfClass: NSString.class]) {
        data = [obj dataUsingEncoding:NSUTF8StringEncoding];
        
    } else if ([obj isKindOfClass: NSDictionary.class] || [obj isKindOfClass: NSArray.class]){
        NSError * error = nil;
        data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:&error];
        if (error) {
#ifdef DEBUG
            DDLog(@"fail to get NSData from obj: %@, error: %@", obj, error);
#endif
        }
    }
    return data;
}

-(NSString *)jsonString{
    NSData *jsonData = self.jsonData;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

-(id)objValue{
    assert([self isKindOfClass: NSString.class] || [self isKindOfClass:NSData.class] || [self isKindOfClass: NSDictionary.class] || [self isKindOfClass: NSArray.class]);
    if ([self isKindOfClass: NSDictionary.class] || [self isKindOfClass: NSArray.class]) {
        return self;
    }
    
    NSError *error = nil;
    if ([self isKindOfClass: NSString.class]) {
        NSData *data = [(NSString *)self dataUsingEncoding:NSUTF8StringEncoding];
        id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if (!error) {
            return obj;
        }
#ifdef DEBUG
        DDLog(@"fail to get dictioanry from JSON: %@, error: %@", data, error);
#endif
    } else if ([self isKindOfClass: NSData.class]) {
        id obj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:&error];
        if (!error) {
            return obj;
        }
#ifdef DEBUG
        DDLog(@"fail to get dictioanry from JSON: %@, error: %@", obj, error);
#endif
    }
    return nil;
}

-(NSDictionary *)dictValue{
    if ([self.objValue isKindOfClass: NSDictionary.class]) {
        return self.objValue;
    }
    return nil;
}

//为 NSObject 扩展 NSCoding 协议里的两个方法, 用来便捷实现复杂对象的归档与反归档
-(void)encodeWithCoder:(NSCoder *)aCoder {
    // 一个临时数据, 用来记录一个类成员变量的个数
    unsigned int ivarCount = 0;
    // 获取一个类所有的成员变量
    Ivar *ivars = class_copyIvarList(self.class, &ivarCount);
    
    // 变量成员变量列表
    for (int i = 0; i < ivarCount; i ++) {
        // 获取单个成员变量
        Ivar ivar = ivars[i];
        // 获取成员变量的名字并将其转换为 OC 字符串
        NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 获取该成员变量对应的值
        id value = [self valueForKey:ivarName];
        // 归档, 就是把对象 key-value 对一对一对的 encode
        [aCoder encodeObject:value forKey:ivarName];
    }
    // 释放 ivars
    free(ivars);
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    // 因为没有 superClass 了
    self = [self init];
    if (self != nil) {
        unsigned int ivarCount = 0;
        Ivar *ivars = class_copyIvarList(self.class, &ivarCount);
        for (int i = 0; i < ivarCount; i ++) {
            
            Ivar ivar = ivars[i];
            NSString *ivarName = [NSString stringWithUTF8String:ivar_getName(ivar)];
            // 反归档, 就是把 key-value 对一对一对 decode
            id value = [aDecoder decodeObjectForKey:ivarName];
            // 赋值
            [self setValue:value forKey:ivarName];
        }
        free(ivars);
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES; //支持加密编码
}

//KVC
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    DDLog(@"不存在键_%@:%@",key,value);
}

-(id)valueForUndefinedKey:(NSString *)key{
    return nil;
}


@end
