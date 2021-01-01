//
//  NNPropertyModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/1/1.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Foundation
import CocoaExpand


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
                let lastItems: [String] = self.parts.subarray(NSRange(location: 2, length: self.parts.count - 2))
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

//    var language: String = ""
    ///是否是代码块属性
    var isBlock: Bool{
        assert(content.count > 0, "content不能为空")
        return content.contains("^")
    }

    ///懒加载描述
    var lazyDes: String{
        var top = """
- (\(type)\(generic))\(name){\n
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
        
        DDLog(name, type, generic)
        
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
            
\t\t].mutableCopy;
"""
            }
            else if type.hasSuffix("Dictionary") {
                result = """
_\(name) = @{
            
\t\t}.mutableCopy;
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
\t\t\t\(type) *view = [[\(type) alloc]initWithFrame:CGRectZero];
\t\t\tview.contentMode = UIViewContentModeScaleAspectFit;
\t\t\tview.backgroundColor = UIColor.blackColor;
\t\t\tview.userInteractionEnabled = YES;
\t\t\tview;
\t\t});

"""
        case _ where type.hasSuffix("View"):
            result = """
_\(name) = ({
\t\t\t\(type) *view = [[\(type) alloc]initWithFrame:CGRectZero];
\t\t\tview;
\t\t});
"""
        case _ where type.hasSuffix("Button"):
            result = """
_\(name) = ({
\t\t\t\(type) *sender = [\(type) buttonWithType:UIButtonTypeCustom];
\t\t\t[sender setTitle:@\"Button\" forState:UIControlStateNormal];
\t\t\tsender.titleLabel.adjustsFontSizeToFitWidth = YES;
\t\t\tsender.imageView.contentMode = UIViewContentModeScaleAspectFit;
\t\t\tsender;
\t\t});
"""
        default:
            if type.hasSuffix("Array") {
                result = """
_\(name) = @[
            
\t\t];
"""
            }
            else if type.hasSuffix("Dictionary") {
                result = """
_\(name) = @{

\t\t};
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
        let propertyName = name.hasPrefix(namePrefix) ? name : namePrefix + name
        
        if isBlock {
            let hContent = """
@property(nonatomic, copy, readonly) \(classType) *(^\(propertyName))(\(blockParams));

"""
            return hContent
        }
        
        let hContent = """
@property(nonatomic, copy, readonly) \(classType) *(^\(propertyName))(\(type));

"""
        return hContent
    }
    ///m 文件内容
    var chainContentM: String{
        let nullDes = attributes.contains("strong") || attributes.contains("copy") == true ? " _Nonnull" : ""
        let propertyName = name.hasPrefix(namePrefix) ? name : namePrefix + name

        if isBlock {
            let mContent = """
- (\(classType) * _Nonnull (^)(\(blockParams)\(nullDes)))\(propertyName){
    return ^(\(blockParams) value) {
        self.\(name) = value;
        return self;
    };
}

"""
            return mContent
        }
                
        let mContent = """
- (\(classType) * _Nonnull (^)(\(type)\(nullDes)))\(propertyName){
    return ^(\(type) value) {
        self.\(name) = value;
        return self;
    };
}

"""
        return mContent
    }
    
    // MARK: -funtions
    static func models(with string: String) -> [NNPropertyModel] {
        if string.contains(";") == false && string.contains("\n") == false{
            let alert = NSAlert()
            alert.messageText = "属性必须;结尾"
            alert.runModal()
            return []
        }
        
        let propertys = string.components(separatedBy: "\n")
            .filter { $0.contains("@property") }
            .map({ str -> NNPropertyModel in
                let model = NNPropertyModel()
                model.content = str
                return model
            })
        return propertys
    }
}
