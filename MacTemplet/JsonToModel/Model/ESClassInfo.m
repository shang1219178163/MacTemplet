//
//  ESClassInfo.m
//  ESJsonFormat
//
//  Created by 尹桥印 on 15/6/28.  Change by ZX on 17/5/17
//  Copyright (c) 2015年 EnjoySR. All rights reserved.
//

#import "ESClassInfo.h"
#import "ESJsonFormatManager.h"
#import "ESJsonFormatSetting.h"
#import "NSApplication+Ext.h"

#import <SwiftExpand-Swift.h>


#import "NNGloble.h"
#import "Const.h"

@implementation ESClassInfo

+ (instancetype)classWithKey:(NSString *)key
                         name:(NSString *)className
                         dic:(NSDictionary *)classDic{
    return [[self alloc]initWithClassNameKey:key
                                  className:className
                                   classDic:classDic];
}

- (instancetype)initWithClassNameKey:(NSString *)classNameKey
                           className:(NSString *)className
                            classDic:(NSDictionary *)classDic{
    self = [super init];
    if (self) {
        self.classNameKey = classNameKey;
        self.className = className;
        self.classDic = classDic;
    }
    return self;
}

- (NSMutableDictionary *)propertyClassDic{
    if (!_propertyClassDic) {
        _propertyClassDic = [NSMutableDictionary dictionary];
    }
    return _propertyClassDic;
}

- (NSMutableDictionary *)propertyArrayDic{
    if (!_propertyArrayDic) {
        _propertyArrayDic = [NSMutableDictionary dictionary];
    }
    return _propertyArrayDic;
}

- (NSArray *)atClassArray{
    NSMutableArray *result = [NSMutableArray array];
    [self.propertyClassDic enumerateKeysAndObjectsUsingBlock:^(id key, ESClassInfo *classInfo, BOOL *stop) {
        [result addObject:classInfo];
        [result addObjectsFromArray:classInfo.atClassArray];
    }];
    
    [self.propertyArrayDic enumerateKeysAndObjectsUsingBlock:^(id key, ESClassInfo *classInfo, BOOL *stop) {
        if (ESJsonFormatSetting.defaultSetting.useGeneric) {
            [result addObject:classInfo];
        }
        [result addObjectsFromArray:classInfo.atClassArray];
    }];
    
    return [result copy];
}

- (NSString *)atClassContent{
    NSArray *atClassArray = self.atClassArray;
    if (atClassArray.count==0) {
        return @"";
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:atClassArray];
    
    NSMutableString *resultStr = [NSMutableString stringWithFormat:@"@class "];
    for (ESClassInfo *classInfo in array) {
        [resultStr appendFormat:@"%@, ",classInfo.className];
    }

    if ([resultStr hasSuffix:@", "]) {
        resultStr = [NSMutableString stringWithString:[resultStr substringToIndex:resultStr.length - 2]];
    }
    [resultStr appendString:@";"];
    return resultStr;
}

- (NSString *)propertyContent{
    return [ESJsonFormatManager parsePropertyContentWithClassInfo:self];
}

- (NSString *)classContentForH{
    return [ESJsonFormatManager parseClassHeaderContentWithClassInfo:self];
}

- (NSString *)classContentForM{
    return [ESJsonFormatManager parseClassImpContentWithClassInfo:self];
}

- (NSString *)classInsertTextViewContentForH{
    NSMutableString *result = [NSMutableString stringWithFormat:@""];
    for (NSString *key in self.propertyClassDic) {
        ESClassInfo *classInfo = self.propertyClassDic[key];
        classInfo.langModel = self.langModel;

        [result appendFormat:@"%@\n\n",classInfo.classContentForH];
        [result appendString:classInfo.classInsertTextViewContentForH];
    }
    
    for (NSString *key in self.propertyArrayDic) {
        ESClassInfo *classInfo = self.propertyArrayDic[key];
        classInfo.langModel = self.langModel;

        [result appendFormat:@"%@\n\n",classInfo.classContentForH];
        [result appendString:classInfo.classInsertTextViewContentForH];
    }
    return result;
}

- (NSString *)classInsertTextViewContentForM{
    NSMutableString *result = [NSMutableString stringWithFormat:@""];
    for (NSString *key in self.propertyClassDic) {
        ESClassInfo *classInfo = self.propertyClassDic[key];
        classInfo.langModel = self.langModel;
        
        [result appendFormat:@"%@\n\n",classInfo.classContentForM];
        [result appendString:classInfo.classInsertTextViewContentForM];
    }
    
    for (NSString *key in self.propertyArrayDic) {
        ESClassInfo *classInfo = self.propertyArrayDic[key];
        classInfo.langModel = self.langModel;
        
        [result appendFormat:@"%@\n\n",classInfo.classContentForM];
        [result appendString:classInfo.classInsertTextViewContentForM];
    }
    return result;

}

- (void)createFileWithFolderPath:(NSString *)folderPath{
    for (NSString *key in self.propertyClassDic) {
        ESClassInfo *classInfo = self.propertyClassDic[key];
        classInfo.langModel = self.langModel;

        [classInfo createFileWithFolderPath:folderPath];
    }
    
    for (NSString *key in self.propertyArrayDic) {
        ESClassInfo *classInfo = self.propertyArrayDic[key];
        classInfo.langModel = self.langModel;

        [classInfo createFileWithFolderPath:folderPath];
    }
    [ESJsonFormatManager createFileWithFolderPath:folderPath classInfo:self];
}

+ (ESClassInfo *)dealWithJson:(id)result handler:(void(^)(NSString *hFilename, NSString *mFilename))handler{
    __block ESClassInfo *classInfo = nil;
    
    NSString *rootClassName = [NSUserDefaults.standardUserDefaults objectForKey:kRootClass];
    if (rootClassName.length <= 0) {
        rootClassName = ESRootClassName;
    }
    
    //如果当前是JSON对应是字典
    if ([result isKindOfClass: NSDictionary.class]) {
        //如果是生成到文件，提示输入Root class name
        if (!ESJsonFormatSetting.defaultSetting.outputToFiles) {
            NSString *className = [[NSUserDefaults.defaults objectForKey:kClassPrefix] stringByAppendingString:rootClassName];

            classInfo = [ESClassInfo classWithKey:ESRootClassName
                                             name:className
                                              dic:result];
            
            BOOL isSwift = NSApplication.isSwift;
            NSString *hName = [className stringByAppendingString: (isSwift ? @".swift" : @".h")];
            NSString *mName = [className stringByAppendingString: (isSwift ? @"" : @".m")];
            if (handler) {
                handler(hName, mName);
            }
            [ESClassInfo dealPropertyNameWithClassInfo:classInfo];
            
        } else {
            //不生成到文件，Root class 里面用户自己创建
            NSString *className = [[NSUserDefaults.defaults objectForKey:kClassPrefix] stringByAppendingString:rootClassName];
            
            classInfo = [ESClassInfo classWithKey:ESRootClassName
                                             name:className
                                              dic:result];
            [ESClassInfo dealPropertyNameWithClassInfo:classInfo];
            
        }
    } else if ([result isKindOfClass: NSArray.class]){
        if (ESJsonFormatSetting.defaultSetting.outputToFiles) {
            //当前是JSON代表数组，生成到文件需要提示用户输入Root Class name，
            NSString *className = [[NSUserDefaults.defaults objectForKey:kClassPrefix] stringByAppendingString:rootClassName];
            //输入完毕之后，将这个class设置
            NSDictionary *dic = [NSDictionary dictionaryWithObject:result forKey:className];
    
            classInfo = [ESClassInfo classWithKey:ESRootClassName
                                             name:className
                                              dic:dic];
            
            [ESClassInfo dealPropertyNameWithClassInfo:classInfo];
        } else {
            //Root class 已存在，只需要输入JSON对应的key的名字
            NSString *className = [[NSUserDefaults.defaults objectForKey:kClassPrefix] stringByAppendingString:rootClassName];
            NSDictionary *dic = [NSDictionary dictionaryWithObject:result forKey:className];
            classInfo = [ESClassInfo classWithKey:ESRootClassName
                                             name:className
                                              dic:dic];
            [ESClassInfo dealPropertyNameWithClassInfo:classInfo];
        }
    }
    return classInfo;
}

+ (ESClassInfo *)dealPropertyNameWithClassInfo:(ESClassInfo *)classInfo{
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:classInfo.classDic];
    for (NSString *key in dic) {
        //取出的可能是NSDictionary或者NSArray
        id obj = dic[key];
        if ([obj isKindOfClass: NSArray.class] || [obj isKindOfClass: NSDictionary.class]) {
            
            NSString *msg = [NSString stringWithFormat:@"The '%@' correspond class name is:",key];
            if ([obj isKindOfClass: NSArray.class]) {
                //May be 'NSString'，will crash
                if (!([[obj firstObject] isKindOfClass: NSDictionary.class] || [[obj firstObject] isKindOfClass: NSArray.class])) {
                    continue;
                }
                msg = [NSString stringWithFormat:@"The '%@' child items class name is:",key];
            }
            
            __block NSString *childClassName = [[NSUserDefaults.standardUserDefaults objectForKey:kClassPrefix] stringByAppendingString: key.capitalizedString];
            if (![childClassName containsString:@"Model"]) {
                childClassName = [childClassName stringByAppendingString:@"Model"];
            }
            
            //如果当前obj是 NSDictionary 或者 NSArray，继续向下遍历
            if ([obj isKindOfClass: NSDictionary.class]) {
                ESClassInfo *childClassInfo = [ESClassInfo classWithKey:key
                                                                   name:childClassName
                                                                    dic:obj];
                
                [ESClassInfo dealPropertyNameWithClassInfo:childClassInfo];
                //设置classInfo里面属性对应class
                [classInfo.propertyClassDic setObject:childClassInfo forKey:key];
                
            } else if ([obj isKindOfClass: NSArray.class]) {
                //如果是 NSArray 取出第一个元素向下遍历
                NSArray *array = obj;
                if (array.firstObject) {
                    NSObject *obj = array.firstObject;
                    //May be 'NSString'，will crash
                    if ([obj isKindOfClass: NSDictionary.class]) {
                        ESClassInfo *childClassInfo = [ESClassInfo classWithKey:key
                                                                           name:childClassName
                                                                            dic:(NSDictionary *)obj];
                        [ESClassInfo dealPropertyNameWithClassInfo:childClassInfo];
                        //设置classInfo里面属性类型为 NSArray 情况下，NSArray 内部元素类型的对应的class
                        [classInfo.propertyArrayDic setObject:childClassInfo forKey:key];
                    }
                }
            }
        }
    }
    return classInfo;
}

- (NSString *)classDescWithFirstFile:(BOOL)isFirstFile{
    ESClassInfo *classInfo = self;
    NSString *dateStr = [NSDateFormatter stringFromDate:NSDate.date fmt:@"yyyy/MM/dd"];
    NSString *modelStr = [NSString stringWithFormat:@"//\n//Created by %@ on %@.\n//\n\n", NSApplication.userName, dateStr];
    modelStr = NSApplication.classCopyright;
    
    NSMutableString *hImportStr = nil;
    NSString *mImportStr = nil;
    if (!NSApplication.isSwift) {
        NSString *hContent = [NSString stringWithFormat:@"%@\n%@\n%@", classInfo.atClassContent, classInfo.classContentForH, classInfo.classInsertTextViewContentForH];
        NSString *mContent = [NSString stringWithFormat:@"%@\n%@", classInfo.classContentForM, classInfo.classInsertTextViewContentForM];
        
        hImportStr = [NSMutableString stringWithString:@"#import <Foundation/Foundation.h>\n\n"];
        NSString *superClassString = [NSUserDefaults.standardUserDefaults objectForKey:kSuperClass];
        if (superClassString.length > 0 && ![superClassString isEqualToString:@"NSObject"]) {
            [hImportStr appendString:[NSString stringWithFormat:@"#import \"%@.h\" \n\n", superClassString]];
        }
        
        mImportStr = [NSString stringWithFormat:@"#import \"%@.h\"\n", classInfo.className];
        hContent = [NSString stringWithFormat:@"%@%@%@", modelStr, hImportStr, hContent];
        mContent = [NSString stringWithFormat:@"%@%@%@", modelStr, mImportStr, mContent];
        return (isFirstFile ? hContent : mContent);
    } else {
        NSString *hContent = [NSString stringWithFormat:@"%@\n\n%@", classInfo.classContentForH, classInfo.classInsertTextViewContentForH];
        
        hImportStr = [NSMutableString stringWithString:@"import Foundation\n\n"];
        hContent = [NSString stringWithFormat:@"%@%@%@", modelStr, hImportStr, hContent];
        return hContent;
    }
    return nil;
}

@end
