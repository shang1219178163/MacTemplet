//
//  ESClassInfo.h
//  ESJsonFormat
//
//  Created by 尹桥印 on 15/6/28.  Change by ZX on 17/5/17
//  Copyright (c) 2015年 EnjoySR. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NNLanguageModel.h"

@interface ESClassInfo : NSObject
/**
 *  实体类的类名
 */
@property (nonatomic, copy) NSString *className;
/**
 *  当前类在JSON里面对应的key
 */
@property (nonatomic, copy) NSString *classNameKey;
/**
 *  当前类对应的字典
 */
@property (nonatomic, strong) NSDictionary *classDic;

/**
 *  当前类里面属性对应为类的字典 [key->JSON字段的key : value->ESClassInfo对象]
 */
@property (nonatomic, strong) NSMutableDictionary *propertyClassDic;

/**
 *  当前类里属性对应为集合(指定集合里面存某个模型，用作MJExtension) [key->JSON字段的key : value->ESClassInfo对象]
 */
@property (nonatomic, strong) NSMutableDictionary *propertyArrayDic;

/**
 *  内容，用于在创建类文件的时候，指定当前类里面引用哪些类-->通过遍历propertyClassDic生成
 */
@property (nonatomic, copy) NSString *atClassContent;

/**
 *  当前类的需要引用的calss集合
 */
@property (nonatomic, copy) NSArray *atClassArray;


/**
 *  所有属性对应的格式化的内容
 */
@property (nonatomic, copy) NSString *propertyContent;

/**
 *  整个类头文件的内容，包含头与尾 -- 会根据是否创建文件添加模板文字
 */
@property (nonatomic, copy) NSString *classContentForH;

/**
 *  整个类实现文件里面的内容，在Swift情况下此参数无效
 */
@property (nonatomic, copy) NSString *classContentForM;


/**
 *  直接插入到.h文件或者与.swift文件中内容 -- 不包含当前类里面属性字段，只有里面引用类的.h文件内容
 */
@property (nonatomic, copy) NSString *classInsertTextViewContentForH;

/**
 *  直接插入到.m文件的内容，在Swift情况下此参数无效
 */
@property (nonatomic, copy) NSString *classInsertTextViewContentForM;

@property (nonatomic, strong) NNLanguageModel *langModel;

+ (instancetype)classWithKey:(NSString *)key
                         name:(NSString *)className
                         dic:(NSDictionary *)classDic;

- (instancetype)initWithClassNameKey:(NSString *)classNameKey
                           className:(NSString *)className
                            classDic:(NSDictionary *)classDic;

/**
 *  创建文件
 *
 *  @param folderPath 文件路径
 */
- (void)createFileWithFolderPath:(NSString *)folderPath;

/**
 *  初始类名，RootClass/JSON为数组/创建文件与否
 *
 *  @param result JSON转成字典或者数组
 *
 *  @return 类信息
 */
+ (ESClassInfo *)dealWithJson:(id)result handler:(void(^)(NSString *hFilename, NSString *mFilename))handler;

/**
 *  处理属性名字(用户输入属性对应字典对应类或者集合里面对应类的名字)
 *
 *  @param classInfo 要处理的ClassInfo
 *
 *  @return 处理完毕的ClassInfo
 */
+ (ESClassInfo *)dealPropertyNameWithClassInfo:(ESClassInfo *)classInfo;

/**
 根据类模型返回完整的文字信息

 @param isFirstFile 是否是.h/.swift文件
 @return 文字信息
 */
- (NSString *)classDescWithFirstFile:(BOOL)isFirstFile;

@end

