//
//  NNPropertySwiftModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/4/22.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa

@objcMembers class NNPropertySwiftModel: NSObject {
    required override init() {}
    
    ///全部字符串内容
    var content: String = ""
    ///()分割的各个部分
    var parts: [String]{
        if content.count == 0 || !content.contains(":") {
            return []
        }
        
        var tmp = content
        if let range = content.range(of: "//") {
            commentDes = String(content[range.lowerBound..<content.endIndex])
            tmp = String(content[tmp.startIndex..<range.lowerBound])
        }
        
        let items = tmp.trimmed.components(separatedBy: CharacterSet(charactersIn: ": {"))
            .filter({ $0.isEmpty == false })
            .map({ $0.trimmed })
        return items
    }
    
    ///修饰符
    var attributes: [String]{
        if !content.contains("var") || parts.count <= 1 {
            return []
        }
        let index = parts.firstIndex(of: "var")
        let items = Array(parts[0...(index! - 1)])
        return items
    }
    ///类型
    private var lastItems: [String]{
        if self.parts.count == 0 {
            return []
        }
        if self.parts.contains("{") {
            return [self.parts.last!]
        }
        return []
    }
    
    ///类型(含 generic)
    var type: String{
        if self.parts.count == 0 {
            return "Any"
        }
        
        if content.contains("[") && content.contains("]") {
            return "[" + content.components(separatedBy: CharacterSet(charactersIn: "[]"))[1] + "]"
        }
        
        let result = parts.last!
        return result
    }
    
    ///泛型/斜变
    var generic: String{
        if self.parts.count == 0 {
            return ""
        }
        return ""
    }
    
    ///变量名称前缀
    var namePrefix: String = ""
    ///变量名称后缀
    var nameSuffix: String = ""
    ///变量名称
    var name: String{
        if parts.count == 0 {
            return ""
        }

        let result = parts.filter { !attributes.contains($0) && $0 != "var" }.first!
        return result
    }
    ///block传参...
    var blockParams: String{
        return "Void"
    }
    
    ///属性所在的类
    var classType: String = "NSObject"

    ///API_AVAILABLE(ios(11.0), tvos(11.0)) API_UNAVAILABLE(watchos);
    var availableDes: String = ""

    ///Code comment
    var commentDes: String = ""

    ///懒加载描述
    var lazyDes: String{
//        DDLog(type, generic, name)
        let result = """
lazy var \(name): \(type) = {
        \(lazyAllocDes)
}()
"""
        return result
    }
    
    ///懒加载创建
    var lazyAllocDes: String{
        var result = ""
//        DDLog(name, type, generic)
        switch type {
        case _ where type.hasSuffix("Button"):
            result = """
let view = \(type)(type: .custom)
view.setTitle("Button", for: .normal);
view.setTitleColor(.blackColor, for: .normal)
view.adjustsImageWhenHighlighted = false

view.addTarget(self, action: #selector(handActionBtn(_:)), for: .touchUpInside)
return view
"""
        case _ where type.hasSuffix("Label"):
            result = """
let view = \(type)(type: .zero)
view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.textAlignment = .left;
view.numberOfLines = 0;
view.lineBreakMode = .byCharWrapping;
return view
"""
        case _ where type.hasSuffix("ImageView"):
            result = """
let view = \(type)(frame: .zero);
view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.isUserInteractionEnabled = true;
view.contentMode = .scaleAspectFit;
view.backgroundColor = .clear
return view
"""
        case _ where type.hasSuffix("TextField"):
            result = """
let view = \(type)(frame: .zero);
view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.textAlignment = .left;
view.contentVerticalAlignment = .center;
view.autocapitalizationType = .none;
view.autocorrectionType = .no;
view.clearButtonMode = .whileEditing;
view.backgroundColor = .white;
return view
"""
            
        case _ where type.hasSuffix("TextView"):
            result = """
let view = \(type)(frame: .zero);
view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.font = UIFont.systemFont(ofSize: 15);
view.textAlignment = .left;
view.autocapitalizationType = .none;
view.autocorrectionType = .no;
view.backgroundColor = .white;

view.layer.borderColor = UIColor.lightGray.cgColor
view.layer.borderWidth = 0.5
return view
"""
        case _ where type.hasSuffix("View"):
            result = """
let view = \(type)(frame: .zero);

return view
"""
        default:
            result = """
let view = \(type)();

return view
"""
        }
        return result
    }
    ///h 文件内容
    var chainContent: String{
        if content.contains("{ get }") {
            return ""
        }
        
        let structKeyword = isStruct ? "mutating " : ""
        
        var propertyName = name
        propertyName = propertyName.hasPrefix(namePrefix) ? propertyName : namePrefix + propertyName
        propertyName = propertyName.hasSuffix(nameSuffix) ? propertyName : propertyName + nameSuffix
        
        var helpContent = ""
        if commentDes != "" && availableDes != "" {
            helpContent = """
    \(commentDes)
    \(availableDes)
"""
        } else if availableDes != "" {
            helpContent = """
    \(availableDes)
"""
        } else if commentDes != "" {
            helpContent = """
    \(commentDes)
"""
        }
        
        var content = """
    \(helpContent)
    \(structKeyword)func \(namePrefix)\(name)\(nameSuffix)(_ \(name): \(type)) -> Self {
        self.\(name) = \(name)
        return self
    }
"""
        if helpContent == "" {
            content = """
    \(structKeyword)func \(namePrefix)\(name)\(nameSuffix)(_ \(name): \(type)) -> Self {
        self.\(name) = \(name)
        return self
    }
"""
        }
        return content
    }
    
    var isStruct = false
    
    
    // MARK: -funtions
    ///文字转属性列表
    static func models(with string: String) -> [NNPropertySwiftModel] {
        let lines = string.components(separatedBy: "\n").filter { $0 != ""}
        
        var isStruct = false
        if let line = lines.filter({ $0.contains(" : ") }).first {
            isStruct = line.contains("struct")
        }

        var dic = [String: String]()
        for (idx, line) in lines.enumerated() {
            if line.trimmed.hasPrefix("@available") && lines[idx+1].contains("var") {
//                DDLog(line, lines[idx+1])
                dic[lines[idx+1]] = line.trimmed
            }
        }
        
        let propertys = lines
            .filter { $0.contains(" var ") && !$0.contains("{ get }")}
            .map({ content -> NNPropertySwiftModel in
                let model = NNPropertySwiftModel()
                model.content = content
                model.isStruct = isStruct
                if dic.keys.contains(content) {
                    model.availableDes = dic[content] ?? ""
                }
                return model
            })
        return propertys
    }
}


