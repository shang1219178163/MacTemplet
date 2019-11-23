//
//  FileManager.m
//  ESJsonFormatForMac
//
//  Created by zx on 17/6/13.
//  Copyright © 2017年 ZX. All rights reserved.
//

#import "FileManager.h"
#import "ESJsonFormat.h"

@implementation FileManager

+ (FileManager *)sharedInstance{
    static FileManager *sharedInstance = nil;
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
    if (![NSUserDefaults.standardUserDefaults boolForKey:kIsSwift]) {
        //创建.h文件
        [NSFileManager createFile:folderPath name:hFileName content:hContent attributes:nil];
        //创建.m文件
        [NSFileManager createFile:folderPath name:mFileName content:mContent attributes:nil];
    }else{
        //创建.swift文件
        [NSFileManager createFile:folderPath name:hFileName content:hContent attributes:nil];
    }
}

@end
