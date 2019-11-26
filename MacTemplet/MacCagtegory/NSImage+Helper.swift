//
//  NSImage+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSImage {
    
    var pngData: Data? {
        return tiffRepresentation?.bitmap?.pngData
    }
    
    var rep: NSBitmapImageRep? {
        if let tiffRepresentation = self.tiffRepresentation {
            return NSBitmapImageRep(data: tiffRepresentation)
        }
        return nil;
    }
    
    var sizePixels: CGSize {
        if let rep = self.rep {
            return CGSize(width: rep.pixelsWide, height: rep.pixelsHigh)
        }
        return CGSize.zero
    }
    /// 调整图像大小
    func resize(_ to: CGSize, isPixels: Bool = false) -> NSImage {
        
        var toSize = to
        let screenScale: CGFloat = NSScreen.main?.backingScaleFactor ?? 1.0
        
        if isPixels {
            toSize.width = to.width / screenScale
            toSize.height = to.height / screenScale
        }
        
        let toRect = NSRect(x: 0, y: 0, width: toSize.width, height: toSize.height)
        let fromRect =  NSRect(x: 0, y: 0, width: size.width, height: size.height)
        
        let newImage = NSImage(size: toRect.size)
        newImage.lockFocus()
        draw(in: toRect, from: fromRect, operation: NSCompositingOperation.copy, fraction: 1.0)
        newImage.unlockFocus()
        
        return newImage
    }
    
   
    
}

@objc extension NSBitmapImageRep {
    var pngData: Data? {
        return representation(using: .png, properties: [:])
    }
    
}

extension Data {
    var bitmap: NSBitmapImageRep? {
        return NSBitmapImageRep(data: self)
    }
    
}

