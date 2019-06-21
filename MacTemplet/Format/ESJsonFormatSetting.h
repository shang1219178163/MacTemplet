//
//  ESJsonFormatSetting.h
//  ESJsonFormat
//
//  Created by 尹桥印 on 15/7/19.  Change by ZX on 17/5/17
//  Copyright (c) 2015年 EnjoySR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESJsonFormatSetting : NSObject

+ (ESJsonFormatSetting *)defaultSetting;

@property(nonatomic, assign) BOOL useGeneric;
@property(nonatomic, assign) BOOL impOjbClassInArray;
@property(nonatomic, assign) BOOL outputToFiles;
@property(nonatomic, assign) BOOL uppercaseKeyWordForId;

@end
