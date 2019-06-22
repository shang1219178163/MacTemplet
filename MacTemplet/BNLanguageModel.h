//
//Created by ESJsonFormatForMac on 19/06/22.
//

#import <Foundation/Foundation.h>

@class BNDatatypesModel,BNUtilitymethodsModel;


@interface BNLanguageModel : NSObject

@property (nonatomic, copy) NSString *arrayType;

@property (nonatomic, strong) NSArray *basicTypesWithSpecialFetchingNeeds;

@property (nonatomic, copy) NSString *booleanGetter;

@property (nonatomic, copy) NSString *briefDescription;

@property (nonatomic, strong) NSArray *constructors;

@property (nonatomic, strong) BNDatatypesModel *dataTypes;

@property (nonatomic, copy) NSString *defaultParentWithUtilityMethods;

@property (nonatomic, copy) NSString *displayLangName;

@property (nonatomic, copy) NSString *fileExtension;

@property (nonatomic, copy) NSString *genericType;

@property (nonatomic, copy) NSString *getter;

@property (nonatomic, copy) NSString *importForEachCustomType;

@property (nonatomic, copy) NSString *instanceVarDefinition;

@property (nonatomic, copy) NSString *langName;

@property (nonatomic, copy) NSString *modelDefinition;

@property (nonatomic, copy) NSString *modelDefinitionWithParent;

@property (nonatomic, copy) NSString *modelEnd;

@property (nonatomic, copy) NSString *modelStart;

@property (nonatomic, strong) NSArray *reservedKeywords;

@property (nonatomic, copy) NSString *setter;

@property (nonatomic, copy) NSString *staticImports;

@property (nonatomic, copy) NSString *supportsFirstLineStatement;

@property (nonatomic, strong) NSArray *utilityMethods;

@property (nonatomic, strong) NSArray *wordsToRemoveToGetArrayElementsType;

@end


@interface BNDatatypesModel : NSObject

@property (nonatomic, copy) NSString *boolType;

@property (nonatomic, copy) NSString *characterType;

@property (nonatomic, copy) NSString *doubleType;

@property (nonatomic, copy) NSString *floatType;

@property (nonatomic, copy) NSString *intType;

@property (nonatomic, copy) NSString *longType;

@property (nonatomic, copy) NSString *stringType;

@end



@interface BNUtilitymethodsModel : NSObject

@property (nonatomic, copy) NSString *propertyMapModelMethod;
@property (nonatomic, copy) NSString *propertyMapPropertyMethod;

@end

