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

@class \(prefix)ListAPI, \(prefix)DetailAPI, \(prefix)AddAPI, \(prefix)DeleteAPI, \(prefix)UpdateAPI;

NS_ASSUME_NONNULL_BEGIN

@protocol \(prefix)ViewModelDelegate <NSObject>

- (void)requestWithModel:(\(prefix)RootModel *)model isRefresh:(BOOL)isRefresh hasNextPage:(BOOL)hasNextPage;

@end

@interface \(prefix)ViewModel : NSObject

@property (nonatomic, strong) \(prefix)ListAPI *listAPI;

@property (nonatomic, strong) \(prefix)DetailAPI *detailAPI;
/// 添加/创建
@property (nonatomic, strong) \(prefix)AddAPI *addAPI;
/// 删除
@property (nonatomic, strong) \(prefix)DeleteAPI *deleteAPI;
/// 修改
@property (nonatomic, strong) \(prefix)UpdateAPI *updateAPI;
        
@property (nonatomic, weak) id <\(prefix)ViewModelDelegate>delegate;

- (void)requestRefresh;

- (void)requestNextPage;

/// 获取列表
- (void)requestListWithRefresh:(BOOL)refresh
                       success:(void(^)(NSArray<NSObject *> *, BOOL, BOOL))success
                       failure:(void(^)(NSString *))failure;
/// 获取详情
- (void)requestDetailWithHandler:(void(^)(NSObject *))handler;
/// 请求添加
- (void)requestAddWithHandler:(void(^)(NSDictionary *))handler;
/// 请求删除
- (void)requestDeleteWithHandler:(void(^)(NSDictionary *))handler;
/// 请求更新
- (void)requestUpdateWithHandler:(void(^)(NSDictionary *))handler;

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
//    [IOPProgressHUD showWithStatus:kAPILoading];
    [self.listAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        \(prefix)RootModel *model = [\(prefix)RootModel yy_modelWithJSON:jsonData];
        if (!model) {
            [IOPProgressHUD showErrorWithStatus:@"数据错误,请稍后重试"];
            return ;
        }
        
        BOOL isRefresh = self.listAPI.pageModel.currPage == self.listAPI.pageModel.firstPage;
        BOOL hasNextPage = model.records.count == self.listAPI.pageModel.perPageCounts;
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestWithModel:isRefresh:hasNextPage:)]) {
            [self.delegate requestWithModel:model isRefresh:isRefresh hasNextPage:hasNextPage];
        }
        [IOPProgressHUD dismiss];

    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.message];
//        if (self.parController && [self.parController respondsToSelector:@selector(requestDetailWithModel:isSuccess:)]) {
//             [self.parController requestDetailWithModel:nil isSuccess:false];
//         }
    }];
}
        
- (void)requestListWithRefresh:(BOOL)refresh
                       success:(void(^)(\(prefix)RootModel *, BOOL, BOOL))success
                       failure:(void(^)(NSString *))failure{
    if (refresh) {
        [self.listAPI.pageModel turnToFirstPage];
    } else {
        [self.listAPI.pageModel turnToNextPage];
    }
    [self.listAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            \(prefix)RootModel *model = [\(prefix)RootModel yy_modelWithJSON:jsonData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!model) {
                    [IOPProgressHUD showErrorWithStatus:@"数据错误,请稍后重试"];
                    return ;
                }
            });
            BOOL isRefresh = self.listAPI.pageModel.currPage == self.listAPI.pageModel.firstPage;
            BOOL hasMore = model.list.count == self.listAPI.pageModel.perPageCounts;
            if (success) {
                success(model, isRefresh, hasMore);
            }
        });

    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.message];
        if (failure) {
            failure(errorModel.message);
        }
    }];
}

- (void)requestDetailWithHandler:(void(^)(NSObject *))handler{
//    [IOPProgressHUD showWithStatus:kAPILoading];
    [self.detailAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            \(prefix)DetailModel *model = [\(prefix)DetailModel yy_modelWithJSON:jsonData];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (!model) {
                    [IOPProgressHUD showErrorWithStatus:kAPIFail];
                    return ;
                }
                if (handler) {
                    handler(model);
                }
                [IOPProgressHUD dismiss];
            });
        });

    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.message];
    }];
}

- (void)requestAddWithHandler:(void(^)(NSDictionary *))handler{
//    [IOPProgressHUD showWithStatus:kAPILoading];
    [self.addAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        if (!jsonData) {
            [IOPProgressHUD showErrorWithStatus:kAPIFail];
            return ;
        }
        if (handler) {
            handler(jsonData);
        }
        [IOPProgressHUD dismiss];
     
    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.message];
    }];
}

- (void)requestDeleteWithHandler:(void(^)(NSDictionary *))handler{
//    [IOPProgressHUD showWithStatus:kAPILoading];
    [self.deleteAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        if (!jsonData) {
            [IOPProgressHUD showErrorWithStatus:kAPIFail];
            return ;
        }
        if (handler) {
            handler(jsonData);
        }
        [IOPProgressHUD dismiss];

    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.message];
    }];
}

- (void)requestUpdateWithHandler:(void(^)(NSDictionary *))handler{
//    [IOPProgressHUD showWithStatus:kAPILoading];
    [self.updateAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        if (!jsonData) {
            [IOPProgressHUD showErrorWithStatus:kAPIFail];
            return ;
        }
        if (handler) {
            handler(jsonData);
        }
        [IOPProgressHUD dismiss];

    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.message];
    }];
}
        
#pragma mark - lazy

- (\(prefix)API *)listAPI{
    if (!_listAPI) {
        _listAPI = [[\(prefix)ListAPI alloc]init];
    }
    return _listAPI;
}
        
- (\(prefix)DetailAPI *)detailAPI{
    if (!_detailAPI) {
        _detailAPI = [[\(prefix)DetailAPI alloc]init];
    }
    return _detailAPI;
}
        
- (\(prefix)AddAPI *)addAPI{
    if (!_addAPI) {
        _addAPI = [[\(prefix)AddAPI alloc]init];
    }
    return _addAPI;
}


- (\(prefix)DeleteAPI *)deleteAPI{
    if (!_deleteAPI) {
        _deleteAPI = [[\(prefix)DeleteAPI alloc]init];
    }
    return _deleteAPI;
}

- (\(prefix)UpdateAPI *)updateAPI{
    if (!_updateAPI) {
        _updateAPI = [[\(prefix)UpdateAPI alloc]init];
    }
    return _updateAPI;
}

@end

"""
    }
}
