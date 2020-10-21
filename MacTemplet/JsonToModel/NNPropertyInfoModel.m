//
//  NNPropertyInfoModel.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NNPropertyInfoModel.h"

@implementation NNPropertyInfoModel

- (instancetype)init{
    self = [super init];
    if (self) {
        _generic = @"";
    }
    return self;
}

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
        string = [string stringByAppendingFormat:@"\t\t\t%@ *view = [[%@ alloc]initWithFrame:CGRectZero];\n", model.type, model.type];
        NSString *other = @"\t\t\tview.contentMode = UIViewContentModeScaleAspectFit;\n\
        \tview.backgroundColor = NSColor.blackColor;\n\
        \tview.userInteractionEnabled = YES;\n\
        \tview;\n\
        });\n";
        string = [string stringByAppendingString:other];

    } else if ([model.type hasSuffix:@"View"]) {
        string = [string stringByAppendingFormat:@"\t\t_%@ = ({\n", model.name];
        string = [string stringByAppendingFormat:@"\t\t\t%@ *view = [[%@ alloc]initWithFrame:CGRectZero];\n", model.type, model.type];
        NSString *other = @"\t\t\tview;\n\
        });\n";
        string = [string stringByAppendingString:other];
        
    } else if ([model.type hasSuffix:@"Button"]) {
        string = [string stringByAppendingFormat:@"\t\t_%@ = ({\n", model.name];
        string = [string stringByAppendingFormat:@"\t\t\t%@ *view = [%@ buttonWithType:UIButtonTypeCustom];\n", model.type, model.type];
        NSString *other = @"\t\t\t[view setTitle:@\"\" forState:UIControlStateNormal];\n\
        \tview.titleLabel.adjustsFontSizeToFitWidth = YES;\n\
        \tview.imageView.contentMode = UIViewContentModeScaleAspectFit;\n\
        \tview;\n\
        });\n";
        string = [string stringByAppendingString:other];
        
    } else {
        string = [string stringByAppendingFormat:@"\t\t_%@ = [[%@ alloc]init];\n", model.name, model.type];
        
    }
    //    DDLog(@"%@, %@",model.propertyType, string);
    return string;
}

- (NSString *)lazyDes{
    assert(self.valid);

    NSMutableString *mstr = [NSMutableString string];
    if ([self.attributes containsObject:@"class"]) {
        [mstr appendFormat:@"static %@%@ * _%@ = nil;\n", self.type, self.generic, self.name];
        [mstr appendFormat:@"+ (%@%@ *)%@{\n", self.type, self.generic, self.name];
    } else {
        [mstr appendFormat:@"- (%@%@ *)%@{\n", self.type, self.generic, self.name];
    }
    [mstr appendFormat:@"\tif (!_%@) {\n", self.name];
    [mstr appendString:self.lazyAllocDes];
    [mstr appendString:@"\t}\n"];
    [mstr appendFormat:@"\treturn _%@;\n", self.name];
    [mstr appendString:@"}\n"];
    return mstr;
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
        NNPropertyInfoModel *propertyModel = [[NNPropertyInfoModel alloc]init];
        if (![obj containsString:@"*"]) {
            return;
        }
        
        if ((![obj containsString:@"("] && [obj containsString:@")"]) || ([obj containsString:@"("] && ![obj containsString:@")"])) {
            return;
        }

        if ([obj containsString:@"<"] && [obj containsString:@">"] ) {
            NSInteger beginIdx = [obj rangeOfString:@"<"].location;
            NSInteger endIdx = [obj rangeOfString:@">"].location;
            NSString *generic = [obj substringWithRange:NSMakeRange(beginIdx, endIdx - beginIdx + 1)];
            propertyModel.generic = generic;
            obj = [obj stringByReplacingOccurrencesOfString:generic withString:@""];
        }
        
        NSString *seperator = @"*";
        if ([obj containsString:@"("] && [obj containsString:@")"]) {
            seperator = @")";
            
            NSInteger beginIdx = [obj rangeOfString:@"("].location;
            NSInteger endIdx = [obj rangeOfString:@")"].location;
            NSString *attribute = [obj substringWithRange:NSMakeRange(beginIdx, endIdx - beginIdx + 1)];
            
            attribute = [attribute stringByReplacingOccurrencesOfString:@" " withString:@""];
            attribute = [attribute stringByReplacingOccurrencesOfString:@"(" withString:@""];
            attribute = [attribute stringByReplacingOccurrencesOfString:@")" withString:@""];
            propertyModel.attributes = [attribute componentsSeparatedByString:@","];
        }
                
        if ([seperator isEqualToString:@")"]) {
            NSRange range = [obj rangeOfString:seperator];
            NSString * content = [obj substringFromIndex:(range.location + 1)];
            content = [content stringByReplacingOccurrencesOfString:@" " withString:@""];
    //        DDLog(@"%@_%@", obj, content);
    
            NSArray *contents = [content componentsSeparatedByString:@"*"];
            propertyModel.type = contents[0];
            propertyModel.name = contents[1];
        } else {
            obj = [obj stringByReplacingOccurrencesOfString:@"@property" withString:@""];
            obj = [obj stringByReplacingOccurrencesOfString:@" " withString:@""];

            NSArray *contents = [obj componentsSeparatedByString:seperator];
            propertyModel.type = contents[0];
            propertyModel.name = contents[1];
        }
        
        [marr addObject:propertyModel];
    }];
    return marr.copy;
}


@end
