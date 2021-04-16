//
//  CleanDerivedData.swift
//  XcodeWayExtensions
//
//  Created by Gesantung on 2018/12/19.
//  Copyright © 2018 Fantageek. All rights reserved.
//

import Foundation
import AppKit

class CleanDerivedData: Navigator {

    var title: String {
        return "Clean Derived Data"
    }

    func navigate() {
        ScriptRunner().run(functionName: "myCleanDerivedData")
    }
}

