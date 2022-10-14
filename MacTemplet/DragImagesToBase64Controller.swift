//
//  DragImagesToBase64Controller.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/4/10.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SnapKit
import SwiftExpand

@available(macOS 10.13, *)
class DragImagesToBase64Controller: NSViewController {
    
    lazy var destinationView: DragDestinationView = {
        let view = DragDestinationView(types: [.png, .fileURL, ])
        view.delegate = self
        return view
    }()
    
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 17, weight: .regular)
        view.isEditable = false
        view.backgroundColor = NSColor.white
//        view.alignment = .center
        view.string = ""
        return view;
    }()
    
    lazy var textViewOne: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 14, weight: .regular)
        view.isEditable = false
        view.backgroundColor = NSColor.clear
//        view.alignment = .center
        view.string = "此工具用于 h5 项目的小图标批量转base64字符串文件而开发;(直接拖拽多个 png 图片到此页面即可);生成的js 文件默认存入下载文件夹;"
        return view;
    }()
    
    
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addSubview(destinationView)
        view.addSubview(textViewOne.enclosingScrollView!)
        view.addSubview(textView.enclosingScrollView!)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        destinationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        textViewOne.enclosingScrollView?.snp.makeConstraints { (make) in
            make.height.equalTo(45)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-0)
        }
        
        textView.enclosingScrollView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(textViewOne.enclosingScrollView!.snp.top).offset(-10)
        }
        
    }
    
    func convertToBase64Name(fileName: String) -> String {
        var name = fileName;
        if name.contains("@3x") {
            name = name.replacingOccurrences(of: "@3x", with: "")
        }
        if name.contains("@2x") {
            name = name.replacingOccurrences(of: "@2x", with: "")
        }
        if name.contains(".png") {
            name = name.replacingOccurrences(of: ".png", with: "")
        }
        let result = "\(name)_base64.js"
        return result;
    }
}


@available(OSX 10.13, *)
extension DragImagesToBase64Controller: DragDestinationViewDelegate {
    
    func processImage(_ image: NSImage, pasteBoard: NSPasteboard) {
        textView.string = "\(image.sizePixels.width) * \(image.sizePixels.height)"
        
        if let property = pasteBoard.propertyList?.first as? String {
            let list = property.components(separatedBy: "/")
            textView.string = "\(list.last ?? "")(\(Int(image.size.width))x\(Int(image.size.height)))"
        }
    }
    
    func process(_ obj: Any, pasteBoard: NSPasteboard) {
        print(#function, #line, obj);
        
        guard let items = obj as? [URL] else {
            print(#function, #line, "文件类型异常");
            return
        }
        
        var mdic = [String: String]();
        
        items.forEach{
            guard let image = NSImage(contentsOfFile: $0.path),
                    let data = image.pngData else {
                return;
            }
            let base64 = "data:image/png;base64," + data.base64EncodedString(options: []);
            mdic[$0.lastPathComponent] = base64;
            
            let base64JS = convertToBase64Name(fileName: $0.lastPathComponent);
            
            FileManager.createFile(content: base64, name: "\(base64JS)", type: "js")
        }
            
//        print("mdic", mdic);
    
        let list = mdic.keys.sorted().map { e -> String in
            let base64JS = convertToBase64Name(fileName: e);
            let result = "\(e) -> \(base64JS)";
            return result
        };
        
        textView.string = list.joined(separator: "\n")
                    
    }
}
