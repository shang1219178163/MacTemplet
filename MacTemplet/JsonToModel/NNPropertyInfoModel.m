//
//  NNPropertyInfoModel.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNPropertyInfoModel.h"

@implementation NNPropertyInfoModel

- (BOOL)valid{
    BOOL isValid = ![self.type isEqualToString:@""] && ![self.name isEqualToString:@""] && self.type != nil && self.name != nil;
    return isValid;
}

- (NSString *)lazyAllocDes{
    NNPropertyInfoModel *model = self;
    NSString * string = @"";
    //    Class clz = NSClassFromString(model.propertyType);
    if ([model.type containsString:@"NSMutable"]) {
        NSString * supperClass = [model.type stringByReplacingOccurrencesOfString:@"NSMutable" withString:@""];
        string = [NSString stringWithFormat:@"\t\t_%@ = [%@ %@];\n", model.name, model.type, supperClass.lowercaseString];
        
    } else if ([model.type hasSuffix:@"ImageView"]) {
        string = [string stringByAppendingFormat:@"\t\t_%@ = ({\n", model.name];
        string = [string stringByAppendingFormat:@"\t\t%@ *view = [[%@ alloc]initWithFrame:CGRectZero];\n", model.type, model.type];
        NSString *other = @"\t\tview.contentMode = UIViewContentModeScaleAspectFit;\n\
        \t\tview.backgroundColor = NSColor.blackColor;\n\
        \t\tview.userInteractionEnabled = YES;\n\
        \t\tview;\n\
        \t});\n";
        string = [string stringByAppendingString:other];

    } else if ([model.type hasSuffix:@"View"]) {
        string = [string stringByAppendingFormat:@"\t\t_%@ = ({\n", model.name];
        string = [string stringByAppendingFormat:@"\t\t%@ *view = [[%@ alloc]initWithFrame:CGRectZero];\n", model.type, model.type];
        NSString *other = @"\t\tview;\n\
        \t});\n";
        string = [string stringByAppendingString:other];
        
    } else if ([model.type hasSuffix:@"Button"]) {
        string = [string stringByAppendingFormat:@"\t\t_%@ = ({\n", model.name];
        string = [string stringByAppendingFormat:@"\t\t%@ *view = [%@ buttonWithType:UIButtonTypeCustom];\n", model.type, model.type];
        NSString *other = @"\t\t[view setTitle:@\"\" forState:UIControlStateNormal];\n\
        \t\tview.titleLabel.adjustsFontSizeToFitWidth = YES;\n\
        \t\tview.imageView.contentMode = UIViewContentModeScaleAspectFit;\n\
        \t\tview;\n\
        \t});\n";
        string = [string stringByAppendingString:other];
        
    } else {
        string = [string stringByAppendingFormat:@"\t\t_%@ = [[%@ alloc]init];\n", model.name, model.type];
        
    }
    //    DDLog(@"%@, %@",model.propertyType, string);
    return string;
}

- (NSString *)lazyDes{
    assert(self.valid);

    NSMutableString *mStr = [NSMutableString string];
    [mStr appendFormat:@"- (%@ *)%@{\n", self.type, self.name];
    [mStr appendFormat:@"\tif (!_%@) {\n", self.name];
    [mStr appendString:self.lazyAllocDes];
    [mStr appendString:@"\t}\n"];
    [mStr appendFormat:@"\treturn _%@;\n", self.name];
    [mStr appendString:@"}\n"];
    return mStr;
}

+ (NSArray<NNPropertyInfoModel *> *)modelsWithString:(NSString *)string{
    if (![string componentsSeparatedByString:@";"]) {
        NSAlert * alert = [[NSAlert alloc]init];
        alert.messageText = @"属性必须;结尾";
        [alert runModal];
        return nil;
    }
    
    __block NSMutableArray * marr = [NSMutableArray array];
    
    NSArray *propertys = [string componentsSeparatedByString:@";"];
    [propertys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NNPropertyInfoModel * propertyModel = [[NNPropertyInfoModel alloc]init];
        if ([obj rangeOfString:@")"].location != NSNotFound) {
            NSRange range = [obj rangeOfString:@")"];
            NSString * content = [obj substringFromIndex:(range.location + 1)];
            content = [content stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceCharacterSet];
            //            DDLog(@"%@_%@", obj, content);
            
            NSArray *contents = [content componentsSeparatedByString:@"*"];
            propertyModel.type = [contents[0] stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceCharacterSet];
            propertyModel.name = [contents[1] stringByTrimmingCharactersInSet: NSCharacterSet.whitespaceCharacterSet];
            
            [marr addObject:propertyModel];
        }
    }];
    return marr.copy;
}

//+ (NSString *)lazyDesWithModel:(NNPropertyInfoModel *)model{
//
//    NSMutableString *mStr = [NSMutableString string];
//    [mStr appendFormat:@"- (%@ *)%@{\n", model.propertyType, model.propertyName];
//    [mStr appendFormat:@"       if (!_%@) {\n", model.propertyName];
//    [mStr appendString:[NNPropertyInfoModel lazyAllocDesWithModel:model]];
//    //    [mStr appendFormat:@"           _%@ = [[%@ alloc]init];\n", model.propertyName, model.propertyType];
//    [mStr appendString:@"       }\n"];
//    [mStr appendFormat:@"       return _%@;\n", model.propertyName];
//    [mStr appendString:@"}\n"];
//    return mStr;
//}
//
//+ (NSString *)lazyAllocDesWithModel:(NNPropertyInfoModel *)model{
//    NSString * string = @"";
//    //    Class clz = NSClassFromString(model.propertyType);
//    if ([model.propertyType containsString:@"NSMutable"]) {
//        NSString * supperClass = [model.propertyType stringByReplacingOccurrencesOfString:@"NSMutable" withString:@""];
//        string = [NSString stringWithFormat:@"           _%@ = [%@ %@];\n", model.propertyName, model.propertyType, supperClass.lowercaseString];
//
//    } else if ([model.propertyType hasSuffix:@"View"]) {
//        string = [string stringByAppendingFormat:@"           _%@ = ({\n", model.propertyName];
//        string = [string stringByAppendingFormat:@"                  %@ *view = [[%@ alloc]initWithFrame:CGRectZero];\n", model.propertyType, model.propertyType];
//        string = [string stringByAppendingString:@"                  view.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;\n\n"];
//
//        string = [string stringByAppendingString:@"                  view;\n"];
//        string = [string stringByAppendingString:@"              });\n"];
//
//    } else {
//        string = [string stringByAppendingFormat:@"           _%@ = [[%@ alloc]init];\n", model.propertyName, model.propertyType];
//
//    }
//    DDLog(@"%@, %@",model.propertyType, string);
//    return string;
//}



@end
