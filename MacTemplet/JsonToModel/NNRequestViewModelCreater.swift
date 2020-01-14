//
//  NNRequestViewModelCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNRequestViewModelCreater: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "swift")
        let prefix = name.getPrefix(with: ["ViewModel",])
        return """
\(copyRight)

import UIKit
import YYModel

@objc protocol \(prefix)ViewModelDelegate{
    @objc func request(with model: \(prefix)RootModel, isRefresh: Bool, hasNextPage: Bool)
}

@objcMembers class \(prefix)ViewModel: NSObject {
    
    @objc weak var delegate: \(prefix)ViewModelDelegate?
    @objc weak var parController: \(prefix)Controlller?

    @objc lazy var listAPI: \(prefix)Api = {
        let api = \(prefix)Api()
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
        let prefix = name.getPrefix(with: ["ViewModel",])
        return """
\(copyRight)

#import <Foundation/Foundation.h>
#import "\(prefix)RootModel.h"

@class \(prefix)Api, \(prefix)Controller;

NS_ASSUME_NONNULL_BEGIN

@protocol \(prefix)ViewModelDelegate <NSObject>

- (void)requestWithModel:(\(prefix)RootModel *)model isRefresh:(BOOL)isRefresh hasNextPage:(BOOL)hasNextPage;

@end

@interface \(prefix)ViewModel : NSObject

@property (nonatomic, strong) \(prefix)Api *listAPI;

@property (nonatomic, weak) id <\(prefix)ViewModelDelegate>delegate;

@property (nonatomic, weak) \(prefix)Controller *parController;

- (void)requestRefresh;

- (void)requestNextPage;

@end

NS_ASSUME_NONNULL_END

"""
    }
    
    /// 获取.h类内容
    static func getContentM(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "m")
        let prefix = name.getPrefix(with: ["ViewModel",])
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
        \(prefix)RootModel *model = [\(prefix)RootModel yy_modelWithJSON:jsonData];
        if (!model) {
            [IOPProgressHUD showErrorWithStatus:@"数据错误"];
            return ;
        }
        
        BOOL isRefresh = self.listAPI.pageModel.currPage == self.listAPI.pageModel.firstPage;
        BOOL hasNextPage = model.records.count == self.listAPI.pageModel.perPageCounts;
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestWithModel:isRefresh:hasNextPage:)]) {
            [self.delegate requestWithModel:model isRefresh:isRefresh hasNextPage:hasNextPage];
        }
        
    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.debugDescription];
//        if (self.parController && [self.parController respondsToSelector:@selector(requestDetailWithModel:isSuccess:)]) {
//             [self.parController requestDetailWithModel:nil isSuccess:false];
//         }
    }];
}

#pragma mark - lazy

- (\(prefix)Api *)listAPI{
    if (!_listAPI) {
        _listAPI = [[\(prefix)Api alloc]init];
    }
    return _listAPI;
}

@end

"""
    }
}
