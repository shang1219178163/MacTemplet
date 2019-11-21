//
//  NSObject+Helper.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/20.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Helper)<NSSecureCoding>

/// NSObject->NSData
@property (nonatomic, strong, readonly) NSData * _Nullable jsonData;
/// NSObject->NSString
@property (nonatomic, strong, readonly) NSString * _Nullable jsonString;
/// NSString/NSData->NSObject/NSDiction/NSArray
@property (nonatomic, strong, readonly) id _Nullable objValue;
/// NSString/NSData->NSDictionary
@property (nonatomic, strong, readonly) NSDictionary * _Nullable dictValue;


//为 NSObject 扩展 NSCoding 协议里的两个方法, 用来便捷实现复杂对象的归档与反归档
-(void)encodeWithCoder:(NSCoder *)aCoder;

-(instancetype)initWithCoder:(NSCoder *)aDecoder;
//KVC
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;

-(id)valueForUndefinedKey:(NSString *)key;

-(BOOL)validObject;

/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(NSColor *)textColor;

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(NSColor *)textColor alignment:(NSTextAlignment)alignment;

/**
 富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width;


- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding;

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者NSFont)
 @param tapFont 特殊部分子体大小(传NSNumber或者NSFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(NSColor *)tapColor alignment:(NSTextAlignment)alignment;

- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont color:(NSColor *)color tapColor:(NSColor *)tapColor alignment:(NSTextAlignment)alignment;


- (NSAttributedString *)getAttString:(NSString *)string textTaps:(id)textTaps tapColor:(NSColor *)tapColor;

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps;


/**
 标题前加*
 
 */
-(NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList;
/**
 单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust;

/**
 (推荐)单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content must:(id)must;

/**
 布尔值转字符串
 
 */
- (NSString *)stringFromBool:(NSNumber *)boolNum;

/**
 字符串转布尔值
 
 */
- (BOOL)stringToBool:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
