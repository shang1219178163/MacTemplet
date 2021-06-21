//
//  NNPropertyModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/1/1.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Foundation
import SwiftExpand


@objcMembers class NNPropertyModel: NSObject {
    required override init() {}
    
    ///全部字符串内容
    var content: String = ""
    ///()分割的各个部分
    var parts: [String]{
        if content.count == 0 || !content.contains("(") {
            return []
        }
        var items = content.components(separatedBy: CharacterSet(charactersIn: "()"))
        items = items.map({ $0.trimmed })
        return items
    }
    
    ///修饰符
    var attributes: [String]{
        if !content.contains("(") || parts.count <= 1 {
            return []
        }
        let items = parts[1].trimmed.components(separatedBy: ",")
        return items
    }
    ///类型
    private var lastItems: [String]{
        if self.parts.count == 0 {
            return []
        }
        let last: String = self.parts.last!.trimmedBy(";")
        if self.content.contains("*") {
            if self.isBlock {
//            "UICollectionViewFlowLayout *(^nn_attributes)(NSArray<NSString *> *);"
                let lastItems: [String] = self.parts.subarray(with: NSRange(location: 2, length: self.parts.count - 2))
                return lastItems
            } else if self.content.contains("<") {
                let lastItems: [String] = last.componentsSeparatedByCharactersInString("<>")
                return lastItems
            }
            let lastItems: [String] = last.trimmed.components(separatedBy: "*")
            return lastItems
        }
        return last.components(separatedBy: " ")
    }
    
    ///类型(含 generic)
    var type: String{
        if self.parts.count == 0 {
            return "id"
        }
        if self.content.contains("*") {
            if self.isBlock {
                let result: String = self.lastItems[0]
                return result
            } else if self.content.contains("<") {
                let result: String = self.lastItems[0] + "<\(self.lastItems[1])> *"
                return result
            }
            return self.lastItems.first! + "\("*")"
        }
        return self.lastItems.first!
    }
    
    ///泛型/斜变
    var generic: String{
        if self.parts.count == 0 || self.content.contains("<") == false {
            return ""
        }
        
        if isBlock {
            return "<\(self.lastItems.last!)>"
        }
        return "<\(self.lastItems[1])>"
    }
    
    ///变量名称前缀
    var namePrefix: String = ""
    ///变量名称后缀
    var nameSuffix: String = ""
    ///变量名称
    var name: String{
        if self.parts.count == 0 {
            return "id"
        }
        if self.isBlock {
            let result: String = self.lastItems[1].replacingOccurrences(of: "^", with: "")
            return result
        }
        let last: String = self.lastItems.last!.trimmed
        let result: String = last.replacingOccurrences(of: "*", with: "")
        return result
    }
    ///block传参...
    var blockParams: String{
        if self.parts.count == 0 {
            return "Void"
        }
        if self.isBlock {
            let result: String = self.lastItems[3]
            return result
        }
        return "Void"
    }
    
    ///属性所在的类
    var classType: String = "NSObject"

    ///API_AVAILABLE(ios(11.0), tvos(11.0)) API_UNAVAILABLE(watchos);
    var availableDes: String = ""

    ///Code comment
    var commentDes: String = ""

//    var language: String = ""
    ///是否是代码块属性
    var isBlock: Bool{
        assert(content.count > 0, "content不能为空")
        return content.contains("^")
    }

    ///懒加载描述
    var lazyDes: String{
//        DDLog(type, generic, name)
        var top = """
- (\(type))\(name){\n
"""
        
        if attributes.contains("class") {
            top = """
static \(type) _\(name) = nil;
+ (\(type))\(name){\n
"""
        }
        
        let result = """
    if (!_\(name)) {
        \(lazyAllocDes)
    }
    return _\(name);
}

"""
        return top + result
    }
    
    ///懒加载创建
    var lazyAllocDes: String{
        var result = ""
//        DDLog(name, type, generic)
        
        var type = self.type
        if generic.count > 0 {
            type = self.type.replacingOccurrences(of: generic, with: "")
        }
        type = type.trimmedBy("*").trimmed
        switch type {
        case _ where type.hasPrefix("NSMutable"):
            let supperClass: String = type.replacingOccurrences(of: "NSMutable", with: "")
            if type.hasSuffix("Array") {
                result = """
_\(name) = @[
            
        ].mutableCopy;
"""
            }
            else if type.hasSuffix("Dictionary") {
                result = """
_\(name) = @{
            
        }.mutableCopy;
"""
            }
            else {
                result = """
_\(name) = [\(type) \(supperClass.lowercased())];
"""
            }
            
        case _ where type.hasSuffix("ImageView"):
            result = """
_\(name) = ({
            \(type) *view = [[\(type) alloc]initWithFrame:CGRectZero];
            view.contentMode = UIViewContentModeScaleAspectFit;
            view.backgroundColor = UIColor.blackColor;
            view.userInteractionEnabled = YES;
            view;
        });

"""
        case _ where type.hasSuffix("View"):
            result = """
_\(name) = ({
            \(type) *view = [[\(type) alloc]initWithFrame:CGRectZero];
            view;
        });
"""
        case _ where type.hasSuffix("Button"):
            result = """
_\(name) = ({
            \(type) *sender = [\(type) buttonWithType:UIButtonTypeCustom];
            [sender setTitle:@\"Button\" forState:UIControlStateNormal];
            sender.titleLabel.adjustsFontSizeToFitWidth = YES;
            sender.imageView.contentMode = UIViewContentModeScaleAspectFit;
            sender;
        });
"""
        default:
            if type.hasSuffix("Array") {
                result = """
_\(name) = @[
            
        ];
"""
            }
            else if type.hasSuffix("Dictionary") {
                result = """
_\(name) = @{

        };
"""
            }
            else {
                result = """
_\(name) = [[\(type) alloc]init];
"""
            }
        }
        return result
    }
    
    ///h 文件内容
    var chainContentH: String{
//        let propertyName = name.hasPrefix(namePrefix) ? name : namePrefix + name
        var propertyName = name
        propertyName = propertyName.hasPrefix(namePrefix) ? propertyName : namePrefix + propertyName
        propertyName = propertyName.hasSuffix(nameSuffix) ? propertyName : propertyName + nameSuffix

        if isBlock {
            var hContent = """
@property(nonatomic, copy, readonly) \(classType) *(^\(propertyName))(\(blockParams));

"""
            if !availableDes.isEmpty{
                hContent = hContent.trimmedBy("\n").trimmedBy(";") + " \(availableDes);"
            }
            if !commentDes.isEmpty{
                hContent = hContent + " \(commentDes)"
            }
            return hContent
        }
        
        var hContent = """
@property(nonatomic, copy, readonly) \(classType) *(^\(propertyName))(\(type));

"""
        if attributes.contains("class") {
            hContent = hContent.replacingOccurrences(of: "readonly)", with: "readonly, class)")
        }
        if !availableDes.isEmpty{
            hContent = hContent.trimmedBy("\n").trimmedBy(";") + " \(availableDes);"
        }
        if !commentDes.isEmpty{
            hContent = hContent + " \(commentDes)"
        }
        return hContent
    }
    ///m 文件内容
    var chainContentM: String{
        let nullDes = attributes.contains("strong") || attributes.contains("copy") == true ? " _Nonnull" : ""
//        let propertyName = name.hasPrefix(namePrefix) ? name : namePrefix + name
        var propertyName = name
        propertyName = propertyName.hasPrefix(namePrefix) ? propertyName : namePrefix + propertyName
        propertyName = propertyName.hasSuffix(nameSuffix) ? propertyName : propertyName + nameSuffix
        
        if isBlock {
            let mContent = """
- (\(classType) * (^)(\(blockParams)\(nullDes)))\(propertyName){
    return ^(\(blockParams) value) {
        self.\(name) = value;
        return self;
    };
}

"""
            return mContent
        }
                
        var mContent = """
- (\(classType) * (^)(\(type)\(nullDes)))\(propertyName){
    return ^(\(type) value) {
        self.\(name) = value;
        return self;
    };
}

"""
        if attributes.contains("class") {
            mContent = mContent.replacingOccurrences(of: "- (", with: "+ (")
        }
        return mContent
    }
    
    // MARK: -funtions
    ///文字转属性列表
    static func models(with string: String) -> [NNPropertyModel] {
        if string.contains(";") == false && string.contains("\n") == false{
            let alert = NSAlert()
            alert.messageText = "属性必须;结尾"
            alert.runModal()
            return []
        }
        
        let propertys = string.components(separatedBy: "\n")
            .filter { $0.hasPrefix("@property") }
            .map({ content -> NNPropertyModel in
                let model = NNPropertyModel()
                model.content = content.contains("(") ? content : content.replacingOccurrences(of: "@property ", with: "@property (atomic)")
//                model.content = content
                model.clearPropertyContent(model.content)
                return model
            })
        return propertys
    }
    ///content 数据清洗
    func clearPropertyContent(_ text: String) {
        if text.contains("//") {
            commentDes = "//" + text.components(separatedBy: "//").last!
            content = text.components(separatedBy: "//").first!
//            DDLog(content, parts)
        }
        
        if (content as NSString).range(of: "API_").location != NSNotFound {
            let range = (text as NSString).range(of: "API_")
            availableDes = (content as NSString).substring(from: range.location).trimmedBy(";").trimmed
            content = text.substringTo(range.location - 2)
//            DDLog(content, parts, name)
        }
        
//        if !content.trimmed.hasSuffix(";") {
//            content += ";"
//        }
//        if text.contains("estimatedItemSize") {
//            DDLog(availableDes)
//            DDLog(commentDes)
//        }
    }
}
