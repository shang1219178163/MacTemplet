//
//  BNShared.h
//  HuiZhuBang
//
//  Created by BIN on 2018/8/20.
//  Copyright © 2018年 WeiHouKeJi. All rights reserved.
//

#ifndef BNShared_h
#define BNShared_h


//条件编译
#if __has_feature(objc_arc)
//ARC


//.h头文件中的单例宏
#define BNSingletonH(name) + (instancetype)shared;

//.m文件中的单例宏
#define BNSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
+ (instancetype)shared{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    _instance = [[self alloc] init];\
});\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
    return _instance;\
}



#else
//MRC


//.h头文件中的单例宏
#define BNSingletonH(name) + (instancetype)shared;

//.m文件中的单例宏
#define BNSingletonM(name) \
static id _instance;\
+ (instancetype)allocWithZone:(struct _NSZone *)zone{\
        static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
        _instance = [super allocWithZone:zone];\
    });\
    return _instance;\
}\
+ (instancetype)shared{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
    _instance = [[self alloc] init];\
    });\
return _instance;\
}\
- (id)copyWithZone:(NSZone *)zone{\
    return _instance;\
}\
- (oneway void)release{\
}\
- (instancetype)retain{\
    return self;\
}\
- (NSUInteger)retainCount{\
    return 1;\
}\
- (instancetype)autorelease{\
    return self;\
}

#endif



#endif /* BNShared_h */
