//
//  Constant.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/21.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ESJsonFormatPluginPath [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Developer/Shared/Xcode/Plug-ins/ESJsonFormat.xcplugin"]

FOUNDATION_EXPORT NSString *const kFolderPath;

FOUNDATION_EXPORT NSString *const kClassPrefix;
FOUNDATION_EXPORT NSString *const kSuperClass;

FOUNDATION_EXPORT NSString *const kIsSwift;
FOUNDATION_EXPORT NSString *const kPodName;

FOUNDATION_EXPORT NSString *const ESFormatResultNotification;
FOUNDATION_EXPORT NSString *const ESRootClassName;
FOUNDATION_EXPORT NSString *const ESItemClassName;
FOUNDATION_EXPORT NSString *const ESArrayKeyName;


NS_ASSUME_NONNULL_BEGIN

@interface Constant : NSObject

@end

NS_ASSUME_NONNULL_END
