//
//  NNPressGestureRecognizer.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/20.
//  Copyright © 2020 Bin Shang. All rights reserved.
//


import Cocoa

/// 解决NSPressGestureRecognizer在模态时失效问题
class NNPressGestureRecognizer: NSPressGestureRecognizer {
    private var hasBegan = false
    private var hasCancelled = false

    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)

        hasCancelled = false

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(minimumPressDuration * 1000))) {
            if !self.hasCancelled {
                self.state = .began
                self.hasBegan = true
            }
        }
    }

    override func mouseUp(with event: NSEvent) {
        if hasBegan {
            self.state = .ended
            self.hasBegan = false
        } else {
            self.hasCancelled = true
        }

        super.mouseUp(with: event)
    }
}

extension NSGestureRecognizer.State: CustomStringConvertible {
    public var description:String {
        switch self {
        case .possible:
            return "possible"
        case .began:
            return "began"
        case .changed:
            return "changed"
        case .ended:
            return "ended"
        case .cancelled:
            return "cancelled"
        case .failed:
            return "failed"
        @unknown default:
            return "default"
        }
    }
}
