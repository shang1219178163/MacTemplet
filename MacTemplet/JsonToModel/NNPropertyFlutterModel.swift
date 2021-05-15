//
//  NNPropertyFlutterModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/5/12.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa

class NNPropertyFlutterModel: NSObject {

    ///文字转属性列表
    static func models(with string: String) -> [String: String] {
        let lines = string.components(separatedBy: "\n")

        var dic = [String: String]()
        for (idx, line) in lines.enumerated() {
            if line.contains("IconData ") {
//                DDLog(line, lines[idx+1])
                dic[lines[idx+1]] = line
            }
        }
        return dic
    }
}
