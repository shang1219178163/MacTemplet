//
//  UImageBatchCreateContoller.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/6/25.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

class UImageBatchCreateContoller: NSViewController {
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addGestureClick { reco in
            self.dismiss(nil)
            DDLog(reco.view)
        }
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
    
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
        convert()
    }
    
    func convert() {
        guard let txt = Bundle.string(forResource: "SFSafeSymbols", ofType: "txt") else {
            DDLog("文件解析失败")
            return }
        DDLog(txt.count)
        let list = txt.componentsSeparatedByCharacters("\n")
        DDLog(list.count)
        
        let tuples = list.map { [self] in return handleToUIImage($0) }
        
        let content = tuples.map { $0.2 }.joined(separator: "\n")
        let hContent =
"""
@available(iOS 13.0, *)
@objc public extension UIImage{
\(content)
}
"""
        FileManager.createFile(content: hContent, name: "UIImage+Icons", type: "swift")
    }
    
    /// swich to image
    /// - Returns: (name, varName, body))
    func handleToUIImage(_ name: String) -> (String, String, String) {
        var varName = name.replacingOccurrences(of: ".", with: "_")
        
        var list = name.components(separatedBy: ".")
        if list[0].hasPrefix("0") || list[0].intValue > 0 {
            list.append(list[0])
            list.removeFirst()

            varName = "\(list.joined(separator: "_"))"
        }
        
        if ["repeat", "case", "return"].contains(varName) {
            varName += "_Image"
        }
        
        let body =
"""
\t/// \(name)
\tstatic let \(varName) = UIImage(systemName: "\(name)")

"""
//        let body =
//"""
//\t/// \(name)
//\tstatic var \(varName): UIImage? {
//\t\treturn UIImage(systemName: "\(name)")
//\t}
//
//"""
        return (name, varName, body)
    }
    
}
