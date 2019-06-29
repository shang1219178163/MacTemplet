
//
//  NSAttributedString+Helper.m
//  MacTemplet
//
//  Created by Bin Shang on 2019/6/27.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

#import "NSAttributedString+Helper.h"

@implementation NSAttributedString (Helper)

+ (NSAttributedString *)attrString:(NSString *)string font:(CGFloat)font alignment:(NSTextAlignment)alignment{
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    paraStyle.alignment = alignment;
    
    NSDictionary *attrDic = @{
                              NSFontAttributeName: [NSFont fontWithName:@"PingFangSC-Light" size:font],
                              NSForegroundColorAttributeName: NSColor.blackColor,
                              NSParagraphStyleAttributeName: paraStyle,
                              };
    
    NSAttributedString * attrString = [[self alloc]initWithString:string attributes:attrDic];
    return attrString;
}

+ (NSAttributedString *)attrString:(NSString *)string{
    return [NSAttributedString attrString:string font:14 alignment:NSTextAlignmentLeft];
}

+(NSAttributedString *)hyperlinkFromString:(NSString *)string withURL:(NSURL *)aURL font:(NSFont *)font{
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString: string];
    
    NSRange range = NSMakeRange(0, attrString.length);
    
//    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc]init];
    NSDictionary * dic = @{
                           NSFontAttributeName: font,
                           NSForegroundColorAttributeName: NSColor.blueColor,
                           NSLinkAttributeName: aURL.absoluteString,
                           NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
//                           NSParagraphStyleAttributeName: paraStyle,
//                           NSBaselineOffsetAttributeName: @15,
                           };
    
    
    [attrString beginEditing];
    [attrString addAttributes:dic range:range];
    [attrString endEditing];
    return attrString;
}


@end
