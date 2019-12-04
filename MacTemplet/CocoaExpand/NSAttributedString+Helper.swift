//
//  NSAttributedString+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc public extension NSAttributedString{
    
    /// 富文本配置字典
    static func AttributeDict(_ type: Int) -> [NSAttributedString.Key: Any]{
        var dic: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:  NSColor.theme,
                                                  NSAttributedString.Key.backgroundColor:  NSColor.white,]
        
        switch type {
        case 1:
            dic[NSAttributedString.Key.underlineStyle] = NSUnderlineStyle.single.rawValue;
            dic[NSAttributedString.Key.underlineColor] = NSColor.theme;
            
        case 2:
            dic[NSAttributedString.Key.strikethroughStyle] = NSUnderlineStyle.single.rawValue;
            dic[NSAttributedString.Key.strikethroughColor] = NSColor.red;
            
        case 3:
            dic[NSAttributedString.Key.obliqueness] = 0.8;
            
        case 4:
            dic[NSAttributedString.Key.expansion] = 0.3;
            
        case 5:
            dic[NSAttributedString.Key.writingDirection] = 3;
            
        default:
            break
        }
        return dic;
    }
    
    /// 富文本特殊部分配置字典
     static func attrDict(_ font: CGFloat = 15, textColor: NSColor = .theme) -> [NSAttributedString.Key: Any] {
         let dic = [NSAttributedString.Key.font: NSFont.systemFont(ofSize:font),
                    NSAttributedString.Key.foregroundColor: textColor,
                    NSAttributedString.Key.backgroundColor: NSColor.clear,
                    ];
         return dic;
     }
     
     /// 富文本整体设置
     static func paraDict(_ font: CGFloat = 15,
                          textColor: NSColor = .theme,
                          alignment: NSTextAlignment = .left) -> [NSAttributedString.Key: Any] {
         let paraStyle = NSMutableParagraphStyle();
         paraStyle.lineBreakMode = .byCharWrapping;
         paraStyle.alignment = alignment;
         
         let mdic = NSMutableDictionary(dictionary: attrDict(font, textColor: textColor));
         mdic.setObject(paraStyle, forKey:kCTParagraphStyleAttributeName as! NSCopying);
         return mdic.copy() as! [NSAttributedString.Key: Any];
     }
     
     /// [源]富文本
     static func attString(_ text: String!,
                                 textTaps: [String]!,
                                 font: CGFloat = 15,
                                 tapFont: CGFloat = 15,
                                 color: NSColor = .black,
                                 tapColor: NSColor = .theme,
                                 alignment: NSTextAlignment = .left) -> NSAttributedString {
         let paraDic = paraDict(font, textColor: color, alignment: alignment)
         let attString = NSMutableAttributedString(string: text, attributes: paraDic)
         textTaps.forEach { ( textTap: String) in
             let nsRange = (text as NSString).range(of: textTap)
             let attDic = attrDict(tapFont, textColor: tapColor)
             attString.addAttributes(attDic, range: nsRange)
         }
         return attString
     }
     
     /// 特定范围子字符串差异华显示
     static func attString(_ text: String!, offsetStart: Int, offsetEnd: Int) -> NSAttributedString! {
         let nsRange = NSRange(location: offsetStart, length: (text.count - offsetStart - offsetEnd))
         let attrString = attString(text, nsRange: nsRange)
         return attrString
     }
     
     /// 字符串差异华显示
     static func attString(_ text: String!, textSub: String) -> NSAttributedString! {
         let range = text.range(of: textSub)
         let nsRange = text.nsRange(from: range!)
         let attrString = attString(text, nsRange: nsRange)
         return attrString
     }
     
     /// nsRange范围子字符串差异华显示
     static func attString(_ text: String!, nsRange: NSRange, font: CGFloat = 15, textColor: NSColor = NSColor.theme) -> NSAttributedString! {
         assert(text.count >= (nsRange.location + nsRange.length))
         
         let attrString = NSMutableAttributedString(string: text)
         
         let attDict = [NSAttributedString.Key.foregroundColor: textColor,
                        NSAttributedString.Key.font: NSFont.systemFont(ofSize: font),
         ]
         attrString.addAttributes(attDict, range: nsRange)
         return attrString
     }
    
    static func attrString(_ text: String, font: CGFloat = 14, textColor: NSColor = NSColor.black, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = alignment;
        
        let attDic = [NSAttributedString.Key.font:  NSFont.systemFont(ofSize: font),
                      NSAttributedString.Key.foregroundColor:  textColor,
                      NSAttributedString.Key.paragraphStyle:  paraStyle,
        ]
        let attString = NSAttributedString(string: text, attributes: attDic)
        return attString;
    }
    
    /// 定义超链接文本颜色样式
    static func hyperlink(_ string: String, url: URL, font: CGFloat = 14) -> NSAttributedString {
        let attString = NSMutableAttributedString(string: string)
        let range = NSMakeRange(0, attString.length)
        
        let attDic = [NSAttributedString.Key.font:  NSFont.systemFont(ofSize: font),
                      NSAttributedString.Key.foregroundColor:  NSColor.blue,
                      NSAttributedString.Key.link:  url.absoluteURL,
                      NSAttributedString.Key.underlineStyle:  NSUnderlineStyle.single.rawValue,
//                      NSAttributedString.Key.baselineOffset:  15,

            ] as [NSAttributedString.Key : Any]
        attString.beginEditing()
        attString.addAttributes(attDic, range: range)
        attString.endEditing()
        return attString;
    }
    /// 包含超链接的全部内容
    static func hyperlink(dic: [String : String], text: String, font: NSFont) -> NSMutableAttributedString {
        let attDic: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font as Any]
        let mattStr = NSMutableAttributedString(string: text, attributes: attDic)
        for e in dic {
            let url = URL(string: e.value)
            let attStr = NSAttributedString.hyperlink(e.key, url: url!, font: font.pointSize)
            let range = (mattStr.string as NSString).range(of: e.key)
            mattStr.replaceCharacters(in: range, with: attStr)
        }
        return mattStr;
    }

}
