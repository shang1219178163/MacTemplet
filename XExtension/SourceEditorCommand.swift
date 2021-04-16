//
//  SourceEditorCommand.swift
//  XExtension
//
//  Created by Bin Shang on 2021/4/1.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        completionHandler(nil)
    }
    
}
