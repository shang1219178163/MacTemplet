//
//  NSURLSession+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/7.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

extension URLSession {
  
    static func getResults(_ url: URL, completionHandler: @escaping ([[String: AnyObject]], NSError?) -> Void) {    
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> Void in
            guard let data = data else {
                completionHandler([], nil)
                return
            }
            do {
                guard let result = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : AnyObject] else {
                    completionHandler([], nil)
                    return
                }
                if let results = result["list"] as? [[String : AnyObject]] {
                    completionHandler(results, nil)
                } else {
                    completionHandler([], nil)
                }
            } catch _ {
                completionHandler([], error as NSError?)
            }
        })
        task.resume()
    }
  
    static func downloadImage(_ imageURL: URL, completionHandler: @escaping (NSImage?, NSError?) -> Void) {
        let task = URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
            guard let data = data, error == nil else {
                completionHandler(nil, error as NSError?)
                return
            }
            let image = NSImage(data: data)
            completionHandler(image, nil)
        })
        task.resume()
    }
}
