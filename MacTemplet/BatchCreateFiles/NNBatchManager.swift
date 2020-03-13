//
//  NNBatchCreateManager.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/12.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

let kTitleList = "List"
let kTitleDetail = "Detail"
let kTitleEntry = "Entry"
let kTitleUpdate = "Update"
let kTitleAdd = "Add"
let kTitleDelete = "Delete"

/// 批量创建文件管理类
class NNBatchManager: NSObject {

    /// 生成UIView文件
    static func createUIViewFiles(_ name: String,  type: String = "swift") {
        var result = ""
        var resultM = ""

        if type.capitalized == "Swift" {
            result = NNViewCreater.getContent(with: name, type: type)
            FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)

        } else if type.capitalized == "Objc" {
            result = NNViewCreater.getContentH(with: name)
            resultM = NNViewCreater.getContentM(with: name)
            FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
            FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
        }
    }
    
    /// 生成UIViewController文件
    static func createControllerFiles(_ name: String, type: String = "swift") {
        var result = ""
        var resultM = ""

        if name.contains("List") {
            if type.capitalized == "Swift" {
                result = NNViewControllerListCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc"  {
                result = NNViewControllerCreater.getContentH(with: name)
                resultM = NNViewControllerCreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
            
        } else if name.contains("Detail") {
            if type.capitalized == "Swift" {
                result = NNViewControllerDetailCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc" {
                result = NNViewControllerCreater.getContentH(with: name)
                resultM = NNViewControllerCreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
        } else if name.contains("Entry") {
            if type.capitalized == "Swift" {
                result = NNViewControllerEntryCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc" {
                result = NNViewControllerCreater.getContentH(with: name)
                resultM = NNViewControllerCreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
        } else {
            if type.capitalized == "Swift" {
                result = NNViewControllerCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc" {
                result = NNViewControllerCreater.getContentH(with: name)
                resultM = NNViewControllerCreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
            
        }
    }
    
    /// 生成ViewModel文件
    static func createViewModelFiles(_ name: String, type: String = "swift") {
        var result = ""
        var resultM = ""
        
        if type.capitalized == "Swift" {
            result = NNRequestViewModelCreater.getContent(with: name, type: type)
            FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
            
        } else if type.capitalized == "Objc"  {
            result = NNRequestViewModelCreater.getContentH(with: name)
            resultM = NNRequestViewModelCreater.getContentM(with: name)
            FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
            FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
        }
    }
    
    /// 生成UIViewController文件
    static func createAPIFiles(_ name: String, type: String = "swift") {
        var result = ""
        var resultM = ""

        if name.contains("List") {
            if type.capitalized == "Swift" {
                result = NNRequestAPIListCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc"  {
                result = NNRequestAPICreater.getContentH(with: name)
                resultM = NNRequestAPICreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
            
        } else if name.contains("Detail") {
            if type.capitalized == "Swift" {
                result = NNRequestAPIDetailCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc"  {
                result = NNRequestAPICreater.getContentH(with: name)
                resultM = NNRequestAPICreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
            
        } else if name.contains("Add") {
            if type.capitalized == "Swift" {
                result = NNRequestAPIAddCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc"  {
                result = NNRequestAPICreater.getContentH(with: name)
                resultM = NNRequestAPICreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
        } else if name.contains("Update") {
            if type.capitalized == "Swift" {
                result = NNRequestAPIUpdateCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc"  {
                result = NNRequestAPICreater.getContentH(with: name)
                resultM = NNRequestAPICreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
        } else if name.contains("Delete") {
            if type.capitalized == "Swift" {
                result = NNRequestAPIDeleteCreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc"  {
                result = NNRequestAPICreater.getContentH(with: name)
                resultM = NNRequestAPICreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
        } else {
            if type.capitalized == "Swift" {
                result = NNRequestAPICreater.getContent(with: name, type: type)
                FileManager.createFile(content: result, name: name, type: type, isCover: true, openDir: true)
                
            } else if type.capitalized == "Objc"  {
                result = NNRequestAPICreater.getContentH(with: name)
                resultM = NNRequestAPICreater.getContentM(with: name)
                FileManager.createFile(content: result, name: name, type: "h", isCover: true, openDir: true)
                FileManager.createFile(content: resultM, name: name, type: "m", isCover: true, openDir: true)
            }
        }
    }
}
