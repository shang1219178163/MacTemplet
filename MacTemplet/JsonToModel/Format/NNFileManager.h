//
//  NNFileManager.h
//  ESJsonFormatForMac
//
//  Created by zx on 17/6/13.
//  Copyright © 2017年 ZX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESClassInfo.h"

@interface NNFileManager : NSObject

+ (NNFileManager *)shared;

- (void)createFileWithFolderPath:(NSString *)folderPath
                       hFileName:(NSString *)hFileName
                       mFileName:(NSString *)mFileName
                       hContent :(NSString *)hContent
                       mContent :(NSString *)mContent;
@end
