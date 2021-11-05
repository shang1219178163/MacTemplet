//
//  UImageBatchCreateByAssetContoller.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/9/9.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftExpand


///拖拽 tree.text 批量生成 UIImage
class UImageBatchCreateByAssetContoller: NSViewController {
    
    
    lazy var destinationView: DragDestinationView = {
        let view = DragDestinationView(types: [.tiff, .color, .string, .fileURL, .html])
        view.delegate = self
        return view
    }()
    
    lazy var textViewTitle: NNTextView = {
        let view = NNTextView.create(.zero)
        view.backgroundColor = NSColor.clear
        view.font = NSFont.systemFont(ofSize: 15, weight: .medium)
        view.string = "";
        
        view.isEditable = false
        return view
    }()
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 14)
        view.string = "";
        
        view.isEditable = false
        return view
    }()

    lazy var btn: NSButton = {
        let view: NSButton = NSButton(frame: .zero)
        view.autoresizingMask = [.width, .height]
        view.font = NSFont.systemFont(ofSize: 15, weight: .medium)
        view.bezelStyle = .regularSquare
        view.title = "选择文档"

        view.addActionHandler { (sender) in
//            NSApp.keyWindow?.makeFirstResponder(nil)
            let panel = NSOpenPanel.open(fileTypes: nil, allowsMultipleSelection: false)
//            DDLog(panel.url)
            self.parseContent(panel.url)
//            self.parseText(forResource: "image assets tree", ofType: "text")
        }
        return view
    }()
        
    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addSubview(destinationView)
        view.addSubview(textViewTitle.enclosingScrollView!)
        view.addSubview(textView.enclosingScrollView!)
        view.addSubview(btn)
        
        let tip =
        """
        将 Assets.xcassets 文件夹通过 tree 命令(tree -d > tree.text)处理之后的 tree.text 加工,生成 UIImage 扩展文件;
        """
        textViewTitle.string = tip
    }
    
    
    override func viewWillAppear() {
        super.viewWillAppear()
                
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        
//        parseText(forResource: "image assets tree", ofType: "text")
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        destinationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        btn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.centerX.equalToSuperview().offset(0)
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(45)
        }
        
        textViewTitle.enclosingScrollView!.snp.remakeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(25)
        }
        
        textView.enclosingScrollView!.snp.remakeConstraints { (make) in
            make.top.equalTo(textViewTitle.enclosingScrollView!.snp.bottom).offset(10)
            make.bottom.equalTo(btn.snp.top).offset(-10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    // MARK: -funtions
    func parseText(forResource name: String, ofType ext: String, suffix: String = ".imageset") {
        guard let content = Bundle.string(forResource: name, ofType: ext) else {
            DDLog("文件解析失败")
            return }
        
        textViewTitle.string = "\(name).\(ext)"
        textView.string = content

        parseContent(content, lineSuffix: suffix)
    }
    
    
    func parseContent(_ url: URL?) {
        guard let url = url else {
            DDLog("url 不能为空")
            return }
        let lastPathComponent = url.lastPathComponent.urlDecoded
        
        guard let content = try? String(contentsOf: url) else {
            DDLog("数据解析失败")
            return }
        DDLog(content.count)
        
        textViewTitle.string = lastPathComponent
        textView.string = content
        if lastPathComponent.hasSuffix(".text") || lastPathComponent.hasSuffix(".txt") {
            parseContent(content)
        }
    }
    
    func parseContent(_ content: String, lineSuffix: String = ".imageset") {
        let lines = content.components(separatedBy: "\n")
        DDLog(lines.count)

        let array = lines
            .filter {
                $0.hasSuffix(lineSuffix) == true
            }
            .map({ e -> String in
                if let fileName = e.components(separatedBy: " ").last, fileName.hasSuffix(lineSuffix){
                    let name = fileName.components(separatedBy: ".").first!
                    
                    let body =
                    """
                    \t/// \(name)
                    \tstatic let \(name) = UIImage(named: "\(name)")!
                    
                    """
                    return body
                }
                return ""
            })
        DDLog(array.count)

        let content = array.joined(separator: "\n")
        
        let hContent =
        """
        @objc public extension UIImage{
        \(content)
        }
        """
        FileManager.createFile(content: hContent, name: "UIImage+\(lineSuffix.capitalized.replacingOccurrences(of: ".", with: ""))", type: "swift")
    }
    
}


@available(OSX 10.13, *)
extension UImageBatchCreateByAssetContoller: DragDestinationViewDelegate {
    
    func processImage(_ image: NSImage, pasteBoard: NSPasteboard) {
//        destinationImageView.image = image
        textView.string = "\(image.sizePixels.width) * \(image.sizePixels.height)"
        
        if let property = pasteBoard.propertyList?.first as? String {
            let list = property.components(separatedBy: "/")
            textView.string = "\(list.last ?? "")(\(Int(image.size.width))x\(Int(image.size.height)))"
        }
    }
    
    func process(_ obj: Any, pasteBoard: NSPasteboard) {
        switch obj {
        case let value as String:
            print(#function, #line, "String", value)
            textView.string = value
            
        case let value as NSColor:
            print(#function, #line, "NSColor", value)
//            destinationImageView.layer?.backgroundColor = value.cgColor
            textView.textColor = value
            
        case let value as URL:
            print(#function, #line, "URL", value.absoluteString.removingPercentEncoding ?? "")
            textView.string = value.lastPathComponent.removingPercentEncoding ?? ""

            parseContent(value)

        default:
            print(#function, #line, obj)
            break
        }
    }
}
