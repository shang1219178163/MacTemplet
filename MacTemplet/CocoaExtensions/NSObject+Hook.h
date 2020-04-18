//
//  NSObject+Hook.h
//  NNCategoryPro
//
//  Created by Bin Shang on 2019/12/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Hook)

/**
 (源方法)实例方法交换

 @param clz     Class或者NSString类型
 @return        YES成功,NO失败
 */
FOUNDATION_EXPORT BOOL SwizzleMethodInstance(Class clz, SEL origSelector, SEL replSelector);

/**
 (源方法)类方法交换
 
 @param clz     Class或者NSString类型
 @return        YES成功,NO失败
 */
FOUNDATION_EXPORT BOOL SwizzleMethodClass(Class clz, SEL origSelector, SEL replSelector);

/**
 实例方法交换
 @return        YES成功,NO失败
 */
+ (BOOL)swizzleMethodInstanceOrigSel:(SEL)origSelector replSel:(SEL)replSelector;

/**
 类方法交换
 @return        YES成功,NO失败
 */
+ (BOOL)swizzleMethodClassOrigSel:(SEL)origSelector replSel:(SEL)replSelector;

/**
 判断方法是否在子类里override了
 
 @param sel 传入要判断的Selector
 @return 返回判断是否被重载的结果
 */
- (BOOL)isMethodOverride:(Class)clz selector:(SEL)sel;

@end

NS_ASSUME_NONNULL_END
