//
//  NNRequestViewModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNRequestViewModel: NSObject {

    /// 获取类前缀
    static func getPrefix(with name: String) -> String {
        var reult = ""
        if name.contains("ViewModel") {
            reult = name.components(separatedBy: "ViewModel").first!
        }
        return reult;
    }
    
    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "swift")
        let prefix = getPrefix(with: name)
        return """
\(copyRight)

import UIKit
import YYModel

@objc protocol \(prefix)ViewModelDelegate{
    @objc func request(with model: IOPParkModelDataModel, isRefresh: Bool, hasNextPage: Bool)
}

@objcMembers class \(prefix)ViewModel: NSObject {
    
    @objc weak var delegate: \(prefix)ViewModelDelegate?

    @objc lazy var listAPI: IOPSaasParkManagementApi = {
        let api = IOPSaasParkManagementApi()
        return api
    }()
    
    // MARK: - funtions
    func requestRefresh() {
        listAPI.pageModel.turnToFirstPage()
        requestInfo()
    }
    
    func requestNextPage() {
        listAPI.pageModel.turnToNextPage()
        requestInfo()
    }
    
    func requestInfo() {
        IOPProgressHUD.show(withStatus: kAPILoading)
        listAPI.startRequest(successBlock: { [weak self] (manager, dic) in
            guard let self = self else { return }
            var model = IOPParkModelDataModel.yy_model(with: dic)
//            let model = NSArray.yy_modelArray(with: IOPParkModelDataModel.self, json: dic)
            if model == nil {
                IOPProgressHUD.showError(withStatus: "数据错误")
                return
            }
            
            let isRefresh = self.listAPI.pageModel.currPage == self.listAPI.pageModel.firstPage()
            let hasNextPage = model!.records.count == self.listAPI.pageModel.perPageCounts
            self.delegate?.request(with: model!, isRefresh: isRefresh, hasNextPage: hasNextPage)
            
        }) { (manager, errorModel) in
            IOPProgressHUD.showError(withStatus: errorModel.description)
        }
    }
    
}


"""
    }
    
    /// 获取.h类内容
    static func getContentH(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "h")
        let prefix = getPrefix(with: name)
        return """
\(copyRight)

#import <Foundation/Foundation.h>
#import "IOPParkModel.h"

@class IOPSaasParkManagementApi, \(prefix)Controller;

NS_ASSUME_NONNULL_BEGIN

@protocol \(prefix)ViewModelDelegate <NSObject>

- (void)requestWithModel:(IOPParkModelDataModel *)model isRefresh:(BOOL)isRefresh hasNextPage:(BOOL)hasNextPage;

@end

@interface \(prefix)ViewModel : NSObject

@property (nonatomic, strong) IOPSaasParkManagementApi *listAPI;

@property (nonatomic, weak) id <\(prefix)ViewModelDelegate>delegate;

@property (nonatomic, weak) \(prefix)Controller *controller;

- (void)requestRefresh;

- (void)requestNextPage;

@end

NS_ASSUME_NONNULL_END

"""
    }
    
    /// 获取.h类内容
    static func getContentM(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "m")
        let prefix = getPrefix(with: name)
        return """
\(copyRight)

#import "\(prefix)ViewModel.h"
#import "YYModel.h"

@interface \(prefix)ViewModel ()


@end

@implementation \(prefix)ViewModel

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
