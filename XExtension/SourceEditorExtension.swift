//
//  SourceEditorExtension.swift
//  XExtension
//
//  Created by Bin Shang on 2021/4/1.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    /*
    func extensionDidFinishLaunching() {
        // If your extension needs to do any work at launch, implement this optional method.
    }
    */
    
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: Any]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        return []
    }
    */
//    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey : Any]] {
//      return MenuManager.navigators.map { navigator in
//        return [
//          XCSourceEditorCommandDefinitionKey.nameKey: navigator.title,
//          XCSourceEditorCommandDefinitionKey.classNameKey: SourceEditorCommand.className(),
//          XCSourceEditorCommandDefinitionKey.identifierKey: Helper.namespacedIdentifier(identifier: navigator.title)
//        ]
//      }
//    }
    
}
