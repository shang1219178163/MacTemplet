//
//  NSTextField+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/18.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSTextField+Helper.h"

@implementation NSTextField (Helper)

- (void)setHyperlinkDic:(NSDictionary *)dic{
    // both are needed, otherwise hyperlink won't accept mousedown
    NSTextField *textField = self;
    
    NSDictionary * attributes = @{
                                  NSFontAttributeName: textField.font,
                                  };
    __block NSMutableAttributedString *mattStr = [[NSMutableAttributedString alloc]initWithString:textField.stringValue attributes:attributes];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSURL *url = [NSURL URLWithString:obj];
        NSAttributedString * attStr = [NSAttributedString hyperlinkFromString:key withURL:url font:textField.font];
        NSRange range = [mattStr.string rangeOfString:key];
        [mattStr replaceCharactersInRange:range withAttributedString:attStr];
        
    }];
    textField.attributedStringValue = mattStr;
    
    textField.cell.wraps = true;
    textField.cell.scrollable = true;
    textField.editable = false;
    textField.selectable = true;
    textField.allowsEditingTextAttributes = true;
    
}

@end
