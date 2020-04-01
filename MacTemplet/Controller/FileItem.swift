//
//  FileItem.swift
//  OutlineView
//
//  Created by Dis3buted on 23/05/16.
//  Copyright © 2016 Seven Years Later. All rights reserved.
//

import Foundation

class FileItem {
    
    var url: URL!
    var parent: FileItem?
    
    static let fileManager = FileManager()
    static let requiredAttributes: Set = [URLResourceKey.isDirectoryKey] // not using just for example
    static let options: FileManager.DirectoryEnumerationOptions = [.skipsHiddenFiles, .skipsPackageDescendants, .skipsSubdirectoryDescendants]
    
    
    lazy var children: [FileItem]? = {
        // empty [URLResourceKey]() don't include any properties, pass nil to get the default properties
        if let enumerator = FileItem.fileManager.enumerator(at: self.url, includingPropertiesForKeys:[URLResourceKey](), options: FileItem.options, errorHandler: nil) {
            
            var files = [FileItem]()
            while let localURL = enumerator.nextObject() as? URL {
                do {
                    // not using properties and if not used catch unnessary
                    //let properties = try (localURL as NSURL).resourceValues(forKeys: FileItem.requiredAttributes)
                    let properties = try localURL.resourceValues(forKeys: FileItem.requiredAttributes)
                    files.append(FileItem(url: localURL, parent: self))
                    
                } catch {
                    print("Error reading file attributes")
                }
            }
            return files
        }
        return nil
    }()
   
    init(url:URL, parent: FileItem?){
        self.url = url
        self.parent = parent
    }
    
    var displayName: String {
        get {
            return self.url.lastPathComponent
        }
    }
    
    var count: Int {
        return (self.children?.count)!
    }
    
    func childAtIndex(_ n: Int) -> FileItem? {
        return self.children![n]
    }
}
