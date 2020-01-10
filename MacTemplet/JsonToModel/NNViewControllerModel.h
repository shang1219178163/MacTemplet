//
//  NNViewControllerModel.h
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/10.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// swift UIViewController 生成器
@interface NNViewControllerModel : NSObject

@property (nonatomic, copy) NSString *name;
/// 目前仅支持swift
@property (nonatomic, copy) NSString *language;

@end

NS_ASSUME_NONNULL_END
