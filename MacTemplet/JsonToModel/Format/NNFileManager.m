//
//  NNFileManager.m
//  ESJsonFormatForMac
//
//  Created by zx on 17/6/13.
//  Copyright © 2017年 ZX. All rights reserved.
//

#import "NNFileManager.h"
#import "ESJsonFormat.h"

#import <CocoaExpand-Swift.h>


@implementation NNFileManager

+ (NNFileManager *)shared{
    static NNFileManager *sharedInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)createFileWithFolderPath:(NSString *)folderPath
                       hFileName:(NSString *)hFileName
                       mFileName:(NSString *)mFileName
                       hContent :(NSString *)hContent
                       mContent :(NSString *)mContent{
    if (!NSApplication.isSwift) {
        //创建.h文件
        [NSFileManager createFileAtPath:folderPath name:hFileName content:hContent attributes:nil isCover:true];
        //创建.m文件
        [NSFileManager createFileAtPath:folderPath name:mFileName content:mContent attributes:nil isCover:true];
    }else{
        //创建.swift文件
        [NSFileManager createFileAtPath:folderPath name:hFileName content:hContent attributes:nil isCover:true];
    }
}

@end
