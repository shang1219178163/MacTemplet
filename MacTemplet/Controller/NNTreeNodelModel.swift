//
//  NNTreeNodelModel.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/8.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNTreeNodelModel: NSObject {

    var parent: NNTreeNodelModel?
    var childs: [NNTreeNodelModel] = []
    var name: String = ""
    var controller: NSViewController = NSViewController()

    func childAtIndex(_ index: Int) -> NNTreeNodelModel? {
        if childs.count == 0 {
            return nil
        }
        return childs[index]
    }
}
