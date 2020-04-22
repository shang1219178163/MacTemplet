//
//  NSObject+Hook.m
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import "NSObject+Hook.h"
#import <objc/runtime.h>

@implementation NSObject (Hook)

BOOL SwizzleInstanceMethod(Class clz, SEL origSelector, SEL replSelector){
    //    NSLog(@"%@,%@,%@",self,self.class,object_getClass(self));
    if (!clz || !origSelector || !replSelector) {
        NSLog(@"Nil Parameter(s) found when swizzling.");
        return NO;
    }
    
    //1. 通过class_getInstanceMethod()函数从当前对象中的method list获取method结构体，如果是类方法就使用class_getClassMethod()函数获取。
    Method original = class_getInstanceMethod(clz, origSelector);
    Method replace = class_getInstanceMethod(clz, replSelector);
    if (!original || !replace) {
        NSLog(@"Swizzling Method(s) not found while swizzling class %@.", NSStringFromClass(clz));
        return NO;
    }

    //2.若UIViewController类没有该方法,那么它会去UIViewController的父类去寻找,为了避免不必要的麻烦,我们先进行一次添加
    //3: 如果原来类没有这个方法,可以成功添加,如果原来类里面有这个方法,那么将会添加失败
    if (class_addMethod(clz, origSelector, method_getImplementation(replace), method_getTypeEncoding(replace))) {
        class_replaceMethod(clz, replSelector, method_getImplementation(original), method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, replace);
    }
    return YES;
}

BOOL SwizzleClassMethod(Class clz, SEL origSelector, SEL replSelector){
    //    NSLog(@"%@,%@,%@",self,self.class,object_getClass(self));
    if (!clz || !origSelector || !replSelector) {
        NSLog(@"Nil Parameter(s) found when swizzling.");
        return NO;
    }
    clz = object_getClass(clz);
//    Class metaClass = objc_getMetaClass(class_getName(clz));

    Method original = class_getClassMethod(clz, origSelector);
    Method replace = class_getClassMethod(clz, replSelector);
    if (!original || !replace) {
        NSLog(@"Swizzling Method(s) not found while swizzling class %@.", NSStringFromClass(clz));
        return NO;
    }
    
    if (class_addMethod(clz, origSelector, method_getImplementation(replace), method_getTypeEncoding(replace))) {
        class_replaceMethod(clz, replSelector, method_getImplementation(original), method_getTypeEncoding(original));
    } else {
        method_exchangeImplementations(original, replace);
    }
    return YES;
}

+ (BOOL)swizzleInstanceMethodSel:(SEL)origSelector withSel:(SEL)replSelector{
    return SwizzleInstanceMethod(self.class, origSelector, replSelector);
}

+ (BOOL)swizzleClassMethodSel:(SEL)origSelector withSel:(SEL)replSelector{
    return SwizzleInstanceMethod(self.class, origSelector, replSelector);
}

- (BOOL)isMethodOverride:(Class)clz selector:(SEL)sel {
    IMP clsIMP = class_getMethodImplementation(clz, sel);
    IMP superClsIMP = class_getMethodImplementation(clz.superclass, sel);
    return clsIMP != superClsIMP;
}

@end
