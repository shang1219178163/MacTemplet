//
//  NNRequestViewCreaterDetail.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/13.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNRequestViewCreaterDetail: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "swift")
        let prefix = name.getPrefix(with: ["ViewModel",])
        return """
\(copyRight)

import UIKit
import YYModel

@objc protocol \(prefix)ViewModelDelegate{
    @objc func request(with model: IOPParkModelDataModel)
}

@objcMembers class \(prefix)ViewModel: NSObject {
    
    @objc weak var delegate: \(prefix)ViewModelDelegate?

    @objc lazy var detailAPI: IOPSaasParkDetailApi = {
        let api = IOPSaasParkDetailApi()
        return api
    }()
    
    // MARK: - funtions
    func requestInfo() {
        IOPProgressHUD.show(withStatus: kAPILoading)
        detailAPI.startRequest(successBlock: { [weak self] (manager, dic) in
            guard let self = self else { return }
            var model = IOPParkModelDataModel.yy_model(with: dic)
//            let model = NSArray.yy_modelArray(with: IOPParkModelDataModel.self, json: dic)
            if model == nil {
                IOPProgressHUD.showError(withStatus: "数据错误")
                return
            }
   
            self.delegate?.request(with: model!)
            
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
#import "IOPParkModel.h"

@class IOPSaasParkDetailApi, \(prefix)Controller;

NS_ASSUME_NONNULL_BEGIN

@protocol \(prefix)ViewModelDelegate <NSObject>

- (void)requestWithModel:(IOPParkModelDataModel *)model;

@end

@interface \(prefix)ViewModel : NSObject

@property (nonatomic, strong) IOPSaasParkDetailApi *detailAPI;

@property (nonatomic, weak) id <\(prefix)ViewModelDelegate>delegate;

@property (nonatomic, weak) \(prefix)Controller *parController;

- (void)requestInfo;

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


- (void)requestInfo {
    
    [IOPProgressHUD showWithStatus:kAPILoading];
    [self.detailAPI startRequestWithSuccessBlock:^(__kindof IOPRequestManager *manager, NSDictionary *jsonData) {
        IOPParkModelDataModel *rootModel = [IOPParkModelDataModel yy_modelWithJSON:jsonData];
        if (!rootModel) {
            [IOPProgressHUD showErrorWithStatus:@"数据错误"];
            return ;
        }

        if (self.delegate && [self.delegate respondsToSelector:@selector(requestWithModel:)]) {
            [self.delegate requestWithModel:rootModel];
        }
        
    } failedBlock:^(__kindof IOPRequestManager *manager, IOPErrorModel *errorModel) {
        [IOPProgressHUD showErrorWithStatus:errorModel.debugDescription];
//        if (self.parController && [self.parController respondsToSelector:@selector(requestDetailWithModel:isSuccess:)]) {
//             [self.parController requestDetailWithModel:nil isSuccess:false];
//         }
    }];
}

#pragma mark - lazy

- (IOPSaasParkDetailApi *)detailAPI{
    if (!_detailAPI) {
        _detailAPI = [[IOPSaasParkDetailApi alloc]init];
    }
    return _detailAPI;
}

@end

"""
    }
}
