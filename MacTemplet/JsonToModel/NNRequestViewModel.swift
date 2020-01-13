//
//  NNControllerViewModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNRequestViewModel: NSObject {

    /// 获取类内容
    static func getContentSwift(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: ".swift")
        return """
\(copyRight)

import UIKit

import SnapKit
import SwiftExpand
        
///
class \(name)ViewModel: NSObject {

}

"""
    }
    
    /// 获取.h类内容
    static func getContentH(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: ".h")
        return """
\(copyRight)

#import <Foundation/Foundation.h>
#import "IOPParkModel.h"

@class IOPSaasParkManagementApi;

NS_ASSUME_NONNULL_BEGIN

@protocol \(name)ViewModelDelegate <NSObject>

- (void)requestWithModel:(IOPParkModelDataModel *)model isRefresh:(BOOL)isRefresh hasNextPage:(BOOL)hasNextPage;

@end

@interface \(name)ViewModel : NSObject

@property (nonatomic, strong) IOPSaasParkManagementApi *listAPI;

@property (nonatomic, weak) id <\(name)ViewModelDelegate>delegate;

- (void)requestRefresh;

- (void)requestNextPage;

@end

NS_ASSUME_NONNULL_END

"""
    }
    
    /// 获取.h类内容
    static func getContentM(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: ".m")
        return """
\(copyRight)

#import "\(name)ViewModel.h"
#import "YYModel.h"

@interface \(name)ViewModel ()


@end

@implementation \(name)ViewModel

- (void)requestRefresh{
    [self.listAPI.pageModel turnToFirstPage];
    [self requestInfo];
}

- (void)requestNextPage{
    [self.listAPI.pageModel turnToNextPage];
    [self requestInfo];
}

- (void)requestInfo {
    
    [IOPProgressHUD showWithStatus:kAPILoading];
    [self.listAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        IOPParkModelDataModel *rootModel = [IOPParkModelDataModel yy_modelWithJSON:jsonData];
        if (!rootModel) {
            [IOPProgressHUD showErrorWithStatus:@"数据错误"];
            return ;
        }
        
        BOOL isRefresh = self.listAPI.pageModel.currPage == self.listAPI.pageModel.firstPage;
        BOOL hasNextPage = rootModel.records.count == self.listAPI.pageModel.perPageCounts;
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestWithModel:isRefresh:hasNextPage:)]) {
            [self.delegate requestWithModel:rootModel isRefresh:isRefresh hasNextPage:hasNextPage];
        }
        
    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.debugDescription];
//        if (self.parController && [self.parController respondsToSelector:@selector(requestDetailWithModel:isSuccess:)]) {
//             [self.parController requestDetailWithModel:nil isSuccess:false];
//         }
    }];
}

#pragma mark - lazy

- (IOPSaasParkManagementApi *)listAPI{
    if (!_listAPI) {
        _listAPI = [[IOPSaasParkManagementApi alloc]init];
    }
    return _listAPI;
}

@end

"""
    }
}
