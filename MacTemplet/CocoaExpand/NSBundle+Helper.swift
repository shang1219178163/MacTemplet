//
//  NSBundle+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension Bundle {

    static func readPath(forResource name: String?, ofType ext: String?) -> [String]? {
        if let path = Bundle.main.path(forResource: name, ofType: ext) {
            do {
                let data = try String(contentsOfFile: path, encoding: .utf8)
                let myStrings = data.components(separatedBy: .newlines)
//                let result = myStrings.joined(separator: ", ")
                DDLog(myStrings)
                return myStrings;
            } catch {
                print(error)
            }
        }
        return nil;
    }
    
}
