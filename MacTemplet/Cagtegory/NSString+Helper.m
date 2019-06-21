//
//  NSString+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/10.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSString+Helper.h"

@implementation NSString (Helper)

-(id)objc{
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:kNilOptions
                                                      error:&error];
    if (error) {
        return error;
    }
    return obj;
}

-(NSDictionary *)dict{
    if ([self.objc isKindOfClass:[NSDictionary class]]) {
        return self.objc;
    }
    return nil;
}

-(NSArray *)array{
    if ([self.objc isKindOfClass:[NSArray class]]) {
        return self.objc;
    }
    return nil;
}


@end
