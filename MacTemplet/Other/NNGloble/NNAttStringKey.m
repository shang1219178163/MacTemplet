//
//  BNAttributedStringKey.m
//  ProductTemplet
//
//  Created by hsf on 2018/8/30.
//  Copyright © 2018年 BN. All rights reserved.
//

#import "NNAttStringKey.h"

@implementation NNAttStringKey

static NSString *_obj = nil;
static NSString *_title = nil;
static NSString *_font = nil;
static NSString *_textColor = nil;
static NSString *_textColor_H = nil;
static NSString *_imgName = nil;
static NSString *_imgName_H = nil;
static NSString *_controlName = nil;
static NSString *_backgroundColor = nil;

+(NSString *)obj{
    if (!_obj) {
        _obj = @"obj";
    }
    return _obj;
}

+(NSString *)title{
    if (!_title) {
        _title = @"title";
    }
    return _title;
}

+(NSString *)font{
    if (!_font) {
        _font = @"font";
    }
    return _font;
}

+(NSString *)textColor{
    if (!_textColor) {
        _textColor = @"textColor";
    }
    return _textColor;
}

+(NSString *)textColor_H{
    if (!_textColor_H) {
        _textColor_H = @"textColor_H";
    }
    return _textColor_H;
}

+(NSString *)imgName{
    if (!_imgName) {
        _imgName = @"imgName";
    }
    return _imgName;
}

+(NSString *)imgName_H{
    if (!_imgName_H) {
        _imgName_H = @"imgName_H";
    }
    return _imgName_H;
}

+(NSString *)controlName{
    if (!_controlName) {
        _controlName = @"controlName";
    }
    return _controlName;
}

+(NSString *)backgroundColor{
    if (!_backgroundColor) {
        _backgroundColor = @"backgroundColor";
    }
    return _backgroundColor;
}

//+(NSString *)foregroundColor{
//    return NSStringFromSelector(_cmd);
//
//}
//
//+(NSString *)foregroundColor{
//    return NSStringFromSelector(_cmd);
//
//}

@end
