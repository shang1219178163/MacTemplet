//
//	
//	MacTemplet
//
//	Created by shang on 2020/01/11 21:44
//	Copyright © 2020 shang. All rights reserved.
//
#import <Foundation/Foundation.h>

@class NNObjectModel, NNBlocksModel, NNBuildingsModel, NNFloorsModel;


@interface NNRootModel : NSObject

@property (nonatomic, strong) NNObjectModel *object;

@property (nonatomic, copy) NSString *status;

@end


@interface NNObjectModel : NSObject

@property (nonatomic, strong) NSArray<NNBlocksModel *> *blocks;

@property (nonatomic, strong) NSArray<NNBuildingsModel *> *buildings;

@property (nonatomic, strong) NSArray<NNFloorsModel *> *floors;

@end



@interface NNBlocksModel : NSObject

@property (nonatomic, copy) NSString *desc;

@property (nonatomic, assign) BOOL disabled;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger value;

@end



@interface NNBuildingsModel : NSObject

@property (nonatomic, assign) BOOL disabled;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger value;

@end



@interface NNFloorsModel : NSObject

@property (nonatomic, assign) BOOL disabled;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger level;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger value;

@end

