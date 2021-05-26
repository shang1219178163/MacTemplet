//
//  ESJsonFormatManager.m
//  ESJsonFormat
//
//  Created by 尹桥印 on 15/6/28. Change by ZX on 17/5/17
//  Copyright (c) 2015年 EnjoySR. All rights reserved.
//

#import "ESJsonFormatManager.h"
#import "ESClassInfo.h"
#import "ESFormatInfo.h"
#import "ESClassInfo.h"
#import "ESPair.h"
#import "ESJsonFormat.h"
#import "ESJsonFormatSetting.h"
#import "ESPbxprojInfo.h"
#import "ESClassInfo.h"

#import <SwiftExpand-Swift.h>

@interface ESJsonFormatManager()


@end

@implementation ESJsonFormatManager

+ (NSString *)parsePropertyContentWithClassInfo:(ESClassInfo *)classInfo{
    NSMutableString *resultStr = [NSMutableString string];
    NSDictionary *dic = classInfo.classDic;
    
    NSArray *list = [dic.allKeys sortedArrayUsingSelector:@selector(compare:)];
    [list enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSObject *obj = dic[key];
        if (NSApplication.isSwift) {
            [resultStr appendFormat:@"\n%@\n", [self formatSwiftWithKey:key value:obj classInfo:classInfo]];
        } else {
            [resultStr appendFormat:@"\n%@\n", [self formatObjcWithKey:key value:obj classInfo:classInfo]];
        }
    }];
    return resultStr;
}

/**
 *  格式化OC属性字符串
 *
 *  @param key       JSON里面key字段
 *  @param value     JSON里面key对应的NSDiction或者NSArray
 *  @param classInfo 类信息
 *
 *  @return NSString
 */
+ (NSString *)formatObjcWithKey:(NSString *)key value:(NSObject *)value classInfo:(ESClassInfo *)classInfo{
    NSString *qualifierStr = @"copy";
    NSString *typeStr = @"NSString";
    //判断大小写
    if ([classInfo.langModel.reservedKeywords containsObject:key] && ESJsonFormatSetting.defaultSetting.uppercaseKeyWordForId) {
        key = [key stringByAppendingString:@"New"];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"@property (nonatomic, %@) %@ *%@;", qualifierStr, typeStr, key];
        
    } else if ([value isKindOfClass:[@(YES) class]]){
        //the 'NSCFBoolean' is private subclass of 'NSNumber'
        qualifierStr = @"assign";
        typeStr = @"BOOL";
        return [NSString stringWithFormat:@"@property (nonatomic, %@) %@ %@;", qualifierStr, typeStr, key];
        
    } else if ([value isKindOfClass:[NSNumber class]]){
        qualifierStr = @"assign";
        NSString *valueStr = [NSString stringWithFormat:@"%@", value];
        if ([valueStr rangeOfString:@"."].location != NSNotFound){
            typeStr = @"CGFloat";
        } else {
            NSNumber *valueNumber = (NSNumber *)value;
            if (valueNumber.longValue < 2147483648) {
                typeStr = @"NSInteger";
            } else {
                typeStr = @"long long";
            }
        }
        return [NSString stringWithFormat:@"@property (nonatomic, %@) %@ %@;", qualifierStr, typeStr, key];
        
    } else if ([value isKindOfClass: NSArray.class]){
        NSArray *array = (NSArray *)value;
        
        //May be 'NSString'，will crash
        NSString *genericTypeStr = @"";
        NSObject *firstObj = array.firstObject;
        if ([firstObj isKindOfClass: NSDictionary.class]) {
            ESClassInfo *childInfo = classInfo.propertyArrayDic[key];
            genericTypeStr = [NSString stringWithFormat:@"<%@ *>", childInfo.className];
        } else if ([firstObj isKindOfClass:[NSString class]]){
            genericTypeStr = @"<NSString *>";
        } else if ([firstObj isKindOfClass:[NSNumber class]]){
            genericTypeStr = @"<NSNumber *>";
        }
        
        qualifierStr = @"strong";
        typeStr = @"NSArray";
        if (ESJsonFormatSetting.defaultSetting.useGeneric) {
            return [NSString stringWithFormat:@"@property (nonatomic, %@) %@%@ *%@;", qualifierStr, typeStr, genericTypeStr, key];
        }
        return [NSString stringWithFormat:@"@property (nonatomic, %@) %@ *%@;", qualifierStr, typeStr, key];
        
    } else if ([value isKindOfClass: NSDictionary.class]){
        qualifierStr = @"strong";
        ESClassInfo *childInfo = classInfo.propertyClassDic[key];
        typeStr = childInfo.className;
        if (!typeStr) {
            typeStr = [key capitalizedString];
        }
        return [NSString stringWithFormat:@"@property (nonatomic, %@) %@ *%@;", qualifierStr, typeStr, key];
    }
    return [NSString stringWithFormat:@"@property (nonatomic, %@) %@ *%@;", qualifierStr, typeStr, key];
}


/**
 *  格式化Swift属性字符串
 *
 *  @param key       JSON里面key字段
 *  @param value     JSON里面key对应的NSDiction或者NSArray
 *  @param classInfo 类信息
 *
 *  @return NSString
 */
+ (NSString *)formatSwiftWithKey:(NSString *)key value:(NSObject *)value classInfo:(ESClassInfo *)classInfo{
    NSString *typeStr = @"String = \"\"";
    //判断大小写
    if ([classInfo.langModel.reservedKeywords containsObject:key] && ESJsonFormatSetting.defaultSetting.uppercaseKeyWordForId) {
        key = [key stringByAppendingString:@"New"];
    }
    if ([value isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"    var %@: %@", key, typeStr];
        
    } else if ([value isKindOfClass:[@(YES) class]]){
        typeStr = @"Bool";
        return [NSString stringWithFormat:@"    var %@: %@ = false", key, typeStr];
        
    } else if ([value isKindOfClass:[NSNumber class]]){
        NSString *valueStr = [NSString stringWithFormat:@"%@", value];
        if ([valueStr rangeOfString:@"."].location!=NSNotFound){
            typeStr = @"Double";
        } else {
            typeStr = @"Int";
        }
        return [NSString stringWithFormat:@"    var %@: %@ = 0", key, typeStr];
        
    } else if ([value isKindOfClass: NSArray.class]){
        ESClassInfo *childInfo = classInfo.propertyArrayDic[key];
        NSString *type = childInfo.className;
        return [NSString stringWithFormat:@"    var %@: [%@]?", key, type == nil ? @"String" : type];
        
    } else if ([value isKindOfClass: NSDictionary.class]){
        ESClassInfo *childInfo = classInfo.propertyClassDic[key];
        typeStr = childInfo.className;
        if (!typeStr) {
            typeStr = [key capitalizedString];
        }
        return [NSString stringWithFormat:@"    var %@: %@?", key, typeStr];
    }
    return [NSString stringWithFormat:@"    var %@: %@", key, typeStr];
}


+ (NSString *)parseClassHeaderContentWithClassInfo:(ESClassInfo *)classInfo{
    if (NSApplication.isSwift) {
        return [self parseClassContentForSwiftWithClassInfo:classInfo];
    } else {
        return [self parseClassHeaderContentForOjbcWithClassInfo:classInfo];
    }
}

+ (NSString *)parseClassImpContentWithClassInfo:(ESClassInfo *)classInfo{
    if (NSApplication.isSwift) {
        return @"";
    }
    
    NSMutableString *result = [NSMutableString stringWithString:@""];
    if (ESJsonFormatSetting.defaultSetting.impOjbClassInArray) {
        [result appendFormat:@"\n@implementation %@\n%@\n%@\n@end\n", classInfo.className, [self methodContentOfObjectClassInArrayWithClassInfo:classInfo], [self methodContentOfObjectIDInArrayWithClassInfo:classInfo]];
    } else {
        [result appendFormat:@"@implementation %@\n\n@end\n", classInfo.className];
    }
    
    if (ESJsonFormatSetting.defaultSetting.outputToFiles) {
        //headerStr
        NSMutableString *headerString = [NSMutableString stringWithString:[self dealHeaderStrWithClassInfo:classInfo type:@"m"]];
        //import
        [headerString appendString:[NSString stringWithFormat:@"#import \"%@.h\"\n", classInfo.className]];
        for (NSString *key in classInfo.propertyArrayDic) {
            ESClassInfo *childClassInfo = classInfo.propertyArrayDic[key];
            [headerString appendString:[NSString stringWithFormat:@"#import \"%@.h\"\n", childClassInfo.className]];
        }
        [headerString appendString:@"\n"];
        [result insertString:headerString atIndex:0];
    }
    return [result copy];
}

/**
 *  解析.h文件内容--Objc
 *
 *  @param classInfo 类信息
 *
 *  @return NSString
 */
+ (NSString *)parseClassHeaderContentForOjbcWithClassInfo:(ESClassInfo *)classInfo{
    NSString *superClassString = [NSUserDefaults.standardUserDefaults valueForKey:kSuperClass];
    superClassString = superClassString.length > 0 ? superClassString : @"NSObject";

    NSMutableString *result = [NSMutableString stringWithFormat:@"\n\n@interface %@ : %@\n", classInfo.className, superClassString];
    [result appendString:classInfo.propertyContent];
    [result appendString:@"\n@end"];
    
    if (ESJsonFormatSetting.defaultSetting.outputToFiles) {
        //headerStr
        NSMutableString *headerString = [NSMutableString stringWithString:[self dealHeaderStrWithClassInfo:classInfo type:@"h"]];
        //@class
        [headerString appendString:[NSString stringWithFormat:@"%@\n\n", classInfo.atClassContent]];
        [result insertString:headerString atIndex:0];
    }
    return [result copy];
}

/**
 *  解析.swift文件内容--Swift
 *
 *  @param classInfo 类信息
 *
 *  @return NSString
 */
+ (NSString *)parseClassContentForSwiftWithClassInfo:(ESClassInfo *)classInfo{
    NSString *superClassString = [NSUserDefaults.standardUserDefaults valueForKey:kSuperClass];
    superClassString = superClassString.length > 0 ? superClassString : @"NSObject";

    NSMutableString *result = [NSMutableString stringWithFormat:@"@objcMembers class %@: %@, %@ {\n", classInfo.className, superClassString, classInfo.langModel.podName];
    [result appendString:classInfo.propertyContent];
    
    NSString *constructors = [classInfo.langModel.constructors componentsJoinedByString:@"\n"];
    [result appendFormat:@"\n    %@", constructors];
    [result appendFormat:@"\n    %@", [self methodContentOfSwiftMapMethodWithClassInfo:classInfo]];
    [result appendFormat:@"\n    %@", [self methodContentOfSwiftObjectClassInArrayWithClassInfo:classInfo]];

    [result appendString:@"\n}"];
    if (ESJsonFormatSetting.defaultSetting.outputToFiles) {
        [result insertString:@"import Cocoa\n\n" atIndex:0];
        //headerStr
        NSMutableString *headerString = [NSMutableString stringWithString:[self dealHeaderStrWithClassInfo:classInfo type:@"swift"]];
        [result insertString:headerString atIndex:0];
    }
    return [result copy];
}

+ (NSString *)methodContentOfSwiftObjectClassInArrayWithClassInfo:(ESClassInfo *)classInfo{
    if (classInfo.propertyArrayDic.count == 0) {
        return @"";
    }
    
    NSMutableString *result = [NSMutableString string];
    for (NSString *key in classInfo.propertyArrayDic) {
        ESClassInfo *childClassInfo = classInfo.propertyArrayDic[key];
        [result appendFormat:@"\"%@\" : %@.self,\n\t\t\t\t", key, childClassInfo.className];
    }
    if ([result hasSuffix:@", "]) {
        result = [NSMutableString stringWithFormat:@"%@", [result substringToIndex:result.length-2]];
    }
    
    NNUtilitymethodsModel *utilityMethodsModel = classInfo.langModel.utilityMethods.firstObject;
    if (!utilityMethodsModel.propertyMapModelMethod) {
        return @"";
    }
    NSString *methodStr = [utilityMethodsModel.propertyMapModelMethod stringByReplacingOccurrencesOfString:@"%@" withString:result];
    return methodStr;
}

+ (NSString *)methodContentOfSwiftMapMethodWithClassInfo:(ESClassInfo *)classInfo{
    NSString *podName = classInfo.langModel.podName;
    
    NSMutableString *result = [NSMutableString string];
    NSArray *keys = classInfo.propertyArrayDic.allKeys.count > 0 ? classInfo.propertyArrayDic.allKeys : classInfo.classDic.allKeys;
    for (NSString *key in keys) {
        if ([classInfo.langModel.reservedKeywords containsObject:key]) {
            if ([podName isEqualToString:@"HandyJSON"]) {
                [result appendFormat:@"\t\tmapper <<< %@New <-- \"%@\";\n", key, key];
            } else if ([podName isEqualToString:@"YYModel"]) {
                [result appendFormat:@"\"%@New\":   \"%@\",\n\t\t\t\t", key, key];
            }
        }
    }
        
    if ([result hasSuffix:@";"]) {
        result = [NSMutableString stringWithFormat:@"%@", [result substringToIndex:result.length-2]];
    }
    
    if ([podName isEqualToString:@"YYModel"] && result.length == 0) {
        [result appendString: @":"];
    }
    
    NNUtilitymethodsModel *utilityMethodsModel = classInfo.langModel.utilityMethods.firstObject;
    NSString *methodStr = [utilityMethodsModel.propertyMapPropertyMethod stringByReplacingOccurrencesOfString:@"%@" withString:result];
    return methodStr;
}

/**
 *  生成 MJExtension 的集合中指定对象的方法
 *
 *  @param classInfo 指定类信息
 *
 *  @return NSString
 */
+ (NSString *)methodContentOfObjectClassInArrayWithClassInfo:(ESClassInfo *)classInfo{
    if (classInfo.propertyArrayDic.count == 0) {
        return @"";
    }
    
    NSMutableString *result = [NSMutableString string];
    for (NSString *key in classInfo.propertyArrayDic) {
        ESClassInfo *childClassInfo = classInfo.propertyArrayDic[key];
        [result appendFormat:@"@\"%@\" : [%@ class],\n\t\t", key, childClassInfo.className];
    }
    if ([result hasSuffix:@", "]) {
        result = [NSMutableString stringWithFormat:@"%@", [result substringToIndex:result.length-2]];
    }
    
    NNUtilitymethodsModel *utilityMethodsModel = classInfo.langModel.utilityMethods.firstObject;
    NSString *methodStr = [utilityMethodsModel.propertyMapModelMethod stringByReplacingOccurrencesOfString:@"%@" withString:result];
    return methodStr;
}


+ (NSString *)methodContentOfObjectIDInArrayWithClassInfo:(ESClassInfo *)classInfo{
    
    NSMutableString *result = [NSMutableString string];
    NSDictionary *dic = classInfo.classDic;

    [dic enumerateKeysAndObjectsUsingBlock:^(id key, NSObject *obj, BOOL *stop) {
        if ([classInfo.langModel.reservedKeywords containsObject:key] && ESJsonFormatSetting.defaultSetting.uppercaseKeyWordForId) {
            [result appendFormat:@"@\"%@New\": @\"%@\", ", key, key];
        }
    }];
    
    if ([result hasSuffix:@", "]) {
        result = [NSMutableString stringWithFormat:@"%@", [result substringToIndex:result.length-2]];
        NNUtilitymethodsModel *utilityMethodsModel = classInfo.langModel.utilityMethods.firstObject;
        NSString *methodStr = [utilityMethodsModel.propertyMapPropertyMethod stringByReplacingOccurrencesOfString:@"%@" withString:result];
        return methodStr;
    }
    return result;
}

/**
 *  拼装模板信息
 *
 *  @param classInfo 类信息
 *  @param type      .h或者.m或者.swift
 *
 *  @return NSString
 */
+ (NSString *)dealHeaderStrWithClassInfo:(ESClassInfo *)classInfo type:(NSString *)type{
//    NSString *type = classInfo.langModel.fileExtension;
    //模板文字
    NSString *path = [NSBundle.mainBundle pathForResource:@"DataModelsTemplate" ofType:@"txt"];
    NSString *templateString = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //替换模型名字
    templateString = [templateString stringByReplacingOccurrencesOfString:@"__MODELNAME__" withString:[NSString stringWithFormat:@"%@.%@", classInfo.className, type]];
    //替换用户名
    templateString = [templateString stringByReplacingOccurrencesOfString:@"__NAME__" withString:NSFullUserName()];
    //产品名
    NSString *productName = ESPbxprojInfo.shareInstance.productName;
    if (productName.length) {
        templateString = [templateString stringByReplacingOccurrencesOfString:@"__PRODUCTNAME__" withString:productName];
    }
    //组织名
    NSString *organizationName = ESPbxprojInfo.shareInstance.organizationName;
    if (organizationName.length) {
        templateString = [templateString stringByReplacingOccurrencesOfString:@"__ORGANIZATIONNAME__" withString:organizationName];
    }
    //时间
    NSString *dateStr = [NSDateFormatter stringFromDate:NSDate.date fmt:@"yy/MM/dd"];
    templateString = [templateString stringByReplacingOccurrencesOfString:@"__DATE__" withString:dateStr];
    
    if ([type isEqualToString:@"h"] || [type isEqualToString:@"swift"]) {
        NSMutableString *string = [NSMutableString stringWithString:templateString];
        if ([type isEqualToString:@"h"]) {
            [string appendString:@"#import <Foundation/Foundation.h>\n\n"];
            NSString *superClassString = [NSUserDefaults.standardUserDefaults valueForKey:kSuperClass];
            if (superClassString.length > 0) {
                [string appendString:[NSString stringWithFormat:@"#import \"%@.h\" \n\n", superClassString]];
            }
        } else {
            [string appendString:@"import Foundation\n\n"];
            NSString *superClassString = [NSUserDefaults.standardUserDefaults valueForKey:kSuperClass];
            if (superClassString.length > 0) {
                [string appendString:[NSString stringWithFormat:@"import %@ \n\n", superClassString]];
            }
        }
        templateString = [string copy];
    }
    return [templateString copy];
}

+ (void)createFileWithFolderPath:(NSString *)folderPath classInfo:(ESClassInfo *)classInfo{
    if (!NSApplication.isSwift) {
        //创建.h文件
        NSString *hFilename = [NSString stringWithFormat:@"%@.h", classInfo.className];
        [NSFileManager createFileAtPath:folderPath name:hFilename content:classInfo.classContentForH attributes:nil isCover:true];;

        //创建.m文件
        NSString *mFilename = [NSString stringWithFormat:@"%@.m", classInfo.className];
        [NSFileManager createFileAtPath:folderPath name:mFilename content:classInfo.classContentForM attributes:nil isCover:true];

    } else {
        //创建.swift文件
        NSString *hFilename = [NSString stringWithFormat:@"%@.swift", classInfo.className];
        [NSFileManager createFileAtPath:folderPath name:hFilename content:classInfo.classContentForH attributes:nil isCover:true];
    }
}

@end
