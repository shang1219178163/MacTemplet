//
//  BNPropertyInfoModel.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNPropertyInfoModel : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *language;

- (BOOL)valid;

- (NSString *)lazyAllocDes;

- (NSString *)lazyDes;

+ (NSArray<BNPropertyInfoModel *> *)modelsWithString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
