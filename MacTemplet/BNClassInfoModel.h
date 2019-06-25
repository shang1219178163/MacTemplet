//
//  BNClassInfoModel.h
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/25.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface BNClassInfoModel : NSObject

@property (nonatomic, copy) NSString *copyright;

@property (nonatomic, copy) NSString *className;
@property (nonatomic, copy) NSString *superClassName;

@property (nonatomic, copy) NSString *atClassStr;
@property (nonatomic, copy) NSString *hImportStr;
@property (nonatomic, copy) NSString *mImportStr;

@property (nonatomic, copy) NSString *hContent;
@property (nonatomic, copy) NSString *mContent;

@end

NS_ASSUME_NONNULL_END
