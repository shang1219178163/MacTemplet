//
//  NSWorkspace+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/5/15.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand

@objc public extension NSWorkspace {

    ///打开系统偏好设置中的隐私界面
    func openPreferencesPrivacy() {
        let string = "x-apple.systempreferences:com.apple.preference.security?Privacy_AllFiles"
        if let url = URL(string: string) {
            NSWorkspace.shared.open(url)
        }
    }
    
}

/*
开发 Mac App 的过程中，需要执行一段 shell 脚本. 下面是实现这个需求的几种方法和相关问题的讨论

使用 NSTask(Swfit 中叫做 Process) 执行 shell
使用 NSAppleScript 借用 appleScript 执行 do shell script echo "echo test" 完成 shell 脚本的执行

NSUserAppleScript 提供了执行 AppleScript 的多线程方案
*/

/// 执行脚本命令(do shell script echo "echo test" )
@objc public extension NSAppleScript {

    static func executeInTerminal(_ scriptText: String) {
        let script = NSAppleScript(source: scriptText)
        var error: NSDictionary?
        script?.executeAndReturnError(&error)
        if var errorMessage = error?["NSAppleScriptErrorBriefMessage"] as? String {
            if let errorNumber = error?["NSAppleScriptErrorNumber"] as? NSNumber,
                errorNumber == NSNumber(integerLiteral: -1728) {
                errorMessage = "Please open Terminal app"
            }
            NSAlert(title: errorMessage, message: scriptText, btnTitles: ["确定"]).runModal()
        }
    }
    
}


public extension NSAppleScript {

    /// 执行脚本命令
    ///
    /// - Parameters:
    ///   - command: 命令行内容
    ///   - needAuthorize: 执行脚本时,是否需要 sudo 授权
    /// - Returns: 执行结果
    private func runCommand(_ command: String, needAuthorize: Bool) -> (isSuccess: Bool, executeResult: String?) {
        let scriptWithAuthorization = """
        do shell script "\(command)" with administrator privileges
        """
        
        let scriptWithoutAuthorization = """
        do shell script "\(command)"
        """
        
        let script = needAuthorize ? scriptWithAuthorization : scriptWithoutAuthorization
        let appleScript = NSAppleScript(source: script)
        
        var error: NSDictionary? = nil
        let result = appleScript!.executeAndReturnError(&error)
        if let error = error {
            print("执行 \n\(command)\n命令出错: \(error.debugDescription)")
            return (false, nil)
        }
        return (true, result.stringValue)
    }
}

//NSUserAppleScriptTask 中很好的一个东西就是结束时候的回调处理。脚本是异步执行的，所以你的用户界面并不会被一个 (比较长) 的脚本锁住。要小心你在结束回调中做的事情，因为它并不是跑在主线程上的，所以你不能在那儿对你的用户界面做更新。
public extension NSUserAppleScriptTask {
    
    func execute(url: URL) throws {
        // 这里的 URL 是 shell 脚本的路径
        let task = try NSUserAppleScriptTask.init(url: url)
        task.execute(withAppleEvent: nil) { (result, error) in
            var message = result?.stringValue ?? ""
            // error.debugDescription 也是执行结果的一部分，有时候超时或执行 shell 本身返回错误，而我们又需要打印这些内容的时候，就需要用到它。
            message = message.count == 0 ? error.debugDescription : message
            NSAlert(title: url.absoluteString, message: message, btnTitles: ["确定"]).runModal()
        }
    }
}
