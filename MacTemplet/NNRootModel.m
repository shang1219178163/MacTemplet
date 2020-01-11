//
//	
//	MacTemplet
//
//	Created by shang on 2020/01/11 21:44
//	Copyright © 2020 shang. All rights reserved.
//
#import "NNRootModel.h"

@implementation NNRootModel


@end


@implementation NNObjectModel

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"blocks" : [NNBlocksModel class],
		@"buildings" : [NNBuildingsModel class],
		@"floors" : [NNFloorsModel class],
		};
}


@end



@implementation NNBlocksModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id", @"desc": @"description"};
}

@end



@implementation NNBuildingsModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id"};
}

@end



@implementation NNFloorsModel


+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper{
    return @{@"ID": @"id"};
}

@end


