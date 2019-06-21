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
        
    } else if ([obj isKindOfClass:[NSDictionary class]] || [obj isKindOfClass:[NSArray class]]){
        NSError * error = nil;
        data = [NSJSONSerialization dataWithJSONObject:obj options:kNilOptions error:&error];
        if (error) {
#ifdef DEBUG
            NSLog(@"fail to get NSData from obj: %@, error: %@", obj, error);
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

- (id)objValue{
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
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", data, error);
#endif
    } else if ([self isKindOfClass: NSData.class]) {
        id obj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:&error];
        if (!error) {
            return obj;
        }
#ifdef DEBUG
        NSLog(@"fail to get dictioanry from JSON: %@, error: %@", obj, error);
#endif
    }
    return nil;
}

- (NSDictionary *)dictValue{
    if ([self.objValue isKindOfClass: NSDictionary.class]) {
        return self.objValue;
    }
    return nil;
}



@end
