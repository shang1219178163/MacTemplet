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

-(BOOL)validObject{
    if ([self isKindOfClass:[NSNull class]]) return NO;
    
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSAttributedString class]]){
        NSString *str = @"";
        if ([self isKindOfClass:[NSAttributedString class]]){
            str = [(NSAttributedString *)self string];
            
        } else {
            str = (NSString *)self;
            
        }
        
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NSArray * array = @[@"",@"nil",@"null"];
        if ([array containsObject:str] || [str containsString:@"null"]) {
            //            DDLog(@"无效字符->(%@)",string);
            return NO;
        }
        
    }
    else if ([self isKindOfClass: NSArray.class]){
        if ([(NSArray *)self count] == 0){
            //            DDLog(@"空数组->(%@)",self);
            return NO;
        }
    }
    else if ([self isKindOfClass: NSDictionary.class]){
        if ([(NSDictionary *)self count] == 0){
            //            DDLog(@"空字典->(%@)",self);
            return NO;
        }
    }
    return YES;
}

#pragma mark- - 富文本
/**
 富文本特殊部分设置
 */
- (NSDictionary *)attrDictWithFont:(id)font textColor:(NSColor *)textColor{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [NSFont systemFontOfSize:[(NSNumber *)font floatValue]];
    }
    // 创建文字属性
    NSDictionary * dict = @{
                            NSFontAttributeName             :   font,
                            NSForegroundColorAttributeName  :   textColor,
                            NSBackgroundColorAttributeName  :   NSColor.clearColor
                            };
    return dict;
}

/**
 富文本整体设置
 */
- (NSDictionary *)attrParaDictWithFont:(id)font textColor:(NSColor *)textColor alignment:(NSTextAlignment)alignment{
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [NSFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSMutableParagraphStyle * paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    //    paraStyle.lineSpacing = 5;//行间距
    
    NSMutableDictionary * mdict = [NSMutableDictionary dictionaryWithDictionary:[self attrDictWithFont:font textColor:textColor]];
    [mdict setObject:paraStyle forKey:NSParagraphStyleAttributeName];
    
    return mdict;
}

/**
 富文本只有和一般文字同字体大小才能计算高度
 */
- (CGSize)sizeWithText:(id)text font:(id)font width:(CGFloat)width{
    if (![text validObject]) return CGSizeZero;
    
    NSAssert([text isKindOfClass:[NSString class]] || [text isKindOfClass:[NSAttributedString class]], @"请检查text格式!");
    NSAssert([font isKindOfClass:[NSFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    if ([font isKindOfClass:[NSNumber class]]) {
        font = [NSFont systemFontOfSize:[(NSNumber *)font floatValue]];
        
    }
    
    NSDictionary *attrDict = [self attrParaDictWithFont:font textColor:NSColor.blackColor alignment:NSTextAlignmentLeft];
    CGSize size = CGSizeZero;
    if ([text isKindOfClass:[NSString class]]) {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attrDict context:nil].size;
        
    } else {
        size = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
        
    }
    size.width = ceil(size.width);
    size.height = ceil(size.height);
    
    return size;
}


- (CGSize)sizeItemsViewWidth:(CGFloat)width items:(NSArray *)items numberOfRow:(NSInteger)numberOfRow itemHeight:(CGFloat)itemHeight padding:(CGFloat)padding{
    
    //    CGFloat padding = 10;
    //    CGFloat viewHeight = 30;
    //    NSInteger numberOfRow = 4;
    NSInteger rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1;
    CGFloat itemWidth = (width - (numberOfRow-1)*padding)/numberOfRow;
    itemHeight = itemHeight == 0.0 ? itemWidth : itemHeight;;
    //
    CGSize size = CGSizeMake(width, rowCount * itemHeight + (rowCount - 1) * padding);
    return size;
}

/**
 (详细)富文本产生
 
 @param text 源字符串
 @param textTaps 特殊部分数组(每一部分都必须包含在text中)
 @param font 一般字体大小(传NSNumber或者NSFont)
 @param tapFont 特殊部分子体大小(传NSNumber或者NSFont)
 @param tapColor 特殊部分颜色
 @return 富文本字符串
 */
- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont tapColor:(NSColor *)tapColor alignment:(NSTextAlignment)alignment{
    return [self getAttString:text textTaps:textTaps font:font tapFont:tapFont color:NSColor.blackColor tapColor:tapColor alignment:alignment];
}

- (NSAttributedString *)getAttString:(NSString *)text textTaps:(NSArray *)textTaps font:(id)font tapFont:(id)tapFont color:(NSColor *)color tapColor:(NSColor *)tapColor alignment:(NSTextAlignment)alignment{
    
    NSAssert(textTaps.count > 0, @"textTaps不能为空!");
    NSAssert([font isKindOfClass:[NSFont class]] || [font isKindOfClass:[NSNumber class]], @"请检查font格式!");
    
    // 设置段落
    NSDictionary *paraDict = [self attrParaDictWithFont:font textColor:color alignment:alignment];
    NSMutableAttributedString * attString = [[NSMutableAttributedString alloc] initWithString:text attributes:paraDict];
    
    for (NSString *textTap in textTaps) {
        //        NSAssert([text containsString:textTap],@"textTaps中有不被字符串包含的元素");
        
        NSRange range = [text rangeOfString:textTap];
        // 创建文字属性
        NSDictionary * attrDict = [self attrDictWithFont:tapFont textColor:tapColor];
        [attString addAttributes:attrDict range:range];
        
    }
    return (NSAttributedString *)attString;
}


- (NSAttributedString *)getAttString:(NSString *)string textTaps:(id)textTaps tapColor:(NSColor *)tapColor{
    if ([textTaps isKindOfClass:[NSString class]]) textTaps = @[textTaps];
    if (!tapColor) tapColor = NSColor.redColor;
    NSAttributedString *attString = [self getAttString:string textTaps:textTaps font:@16 tapFont:@16 tapColor:tapColor alignment:NSTextAlignmentLeft];
    return attString;
}

/**
 富文本产生
 */
- (NSMutableAttributedString *)getAttString:(NSString *)string textTaps:(NSArray *)textTaps{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:string];
    [attString addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:17] range:NSMakeRange(0, string.length)];
    
    for (NSInteger i = 0; i < textTaps.count; i++) {
        [attString addAttribute:NSForegroundColorAttributeName value:NSColor.orangeColor range:[string rangeOfString:textTaps[i]]];
        [attString addAttribute:NSFontAttributeName value:[NSFont systemFontOfSize:17] range:[string rangeOfString:textTaps[i]]];
        
    }
    return attString;
}


/**
 标题前加*
 
 */
-(NSArray *)getAttListByPrefix:(NSString *)prefix titleList:(NSArray *)titleList mustList:(NSArray *)mustList{
    
    NSMutableArray * marr = [NSMutableArray arrayWithCapacity:0];
    
    for (NSString * item in titleList) {
        NSString * title = item;
        if (![title hasPrefix:prefix]) title = [prefix stringByAppendingString:title];
        if (![marr containsObject:title]) [marr addObject:title];
        
        NSColor * colorMust = [mustList containsObject:title] ? NSColor.redColor : NSColor.clearColor;
        
        NSArray * textTaps = @[prefix];
        NSAttributedString * attString = [self getAttString:title textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
        
        if (![marr containsObject:attString]) {
            NSInteger index = [marr indexOfObject:title];
            [marr replaceObjectAtIndex:index withObject:attString];
            
        }
    }
    return marr.copy;
}
/**
 单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content isMust:(BOOL)isMust{
    
    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
    
    NSColor * colorMust = isMust ? NSColor.redColor : NSColor.clearColor;
    
    NSArray * textTaps = @[prefix];
    NSAttributedString * attString = [self getAttString:content textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
    return attString;
}

/**
 (推荐)单个标题前加*
 
 */
- (NSAttributedString *)getAttringByPrefix:(NSString *)prefix content:(NSString *)content must:(id)must{
    
    BOOL isMust = NO;
    if ([must isKindOfClass:[NSString class]]) {
        //        isMust = [self stringToBool:must];
        isMust = [must isEqualToString:@"1"] ? YES : NO;
        
    }
    else if ([must isKindOfClass:[NSNumber class]]){
        isMust = [must boolValue];
        
    }
    else{
        NSAssert([must isKindOfClass:[NSString class]] || [must isKindOfClass:[NSNumber class]], @"请检查数据类型!");
        
    }
    
    if (![content hasPrefix:prefix]) content = [prefix stringByAppendingString:content];
    
    NSColor * colorMust = isMust ? NSColor.redColor : NSColor.clearColor;
    
    NSArray * textTaps = @[prefix];
    NSAttributedString * attString = [self getAttString:content textTaps:textTaps font:@15 tapFont:@15 tapColor:colorMust alignment:NSTextAlignmentCenter];
    return attString;
}

/**
 布尔值转字符串
 
 */
- (NSString *)stringFromBool:(NSNumber *)boolNum {
    NSParameterAssert([boolNum boolValue]  || [boolNum boolValue] == NO);
    
    NSString *string = [boolNum boolValue]  ? @"1"  :   @"0";
    return string;
}

/**
 字符串转布尔值
 
 */
- (BOOL)stringToBool:(NSString *)string{
    NSAssert(([@[@"1",@"0"] containsObject:string] ), @"string值只能为1或者0");
    
    BOOL boolValue = [string integerValue] == 1 ? YES : NO;
    return boolValue;
}


@end
