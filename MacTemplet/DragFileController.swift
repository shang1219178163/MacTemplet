//
//  DragFileController.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/4/10.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import SnapKit
import CocoaExpand

@available(macOS 10.13, *)
class DragFileController: NSViewController {
    
    lazy var destinationImageView: NSImageView = {
        let view = NSImageView()
        view.imageScaling = .scaleProportionallyDown
        
        view.layer?.cornerRadius = 8;
        return view
    }()

    lazy var destinationView: DragDestinationView = {
        let view = DragDestinationView(types: [.tiff, .color, .string, .fileURL, .html])
        view.delegate = self
        return view
    }()
    
    
    lazy var textView: NNTextView = {
        let view = NNTextView.create(.zero)
        view.font = NSFont.systemFont(ofSize: 17, weight: .semibold)
        view.isEditable = false
        view.backgroundColor = NSColor.systemYellow
        view.alignment = .center
        view.string = "描述信息"
        return view;
    }()
    
    
    var showAlertAgain = true
    

    // MARK: -lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        view.addSubview(destinationImageView)
        view.addSubview(destinationView)
        view.addSubview(textView.enclosingScrollView!)
        destinationImageView.layer?.backgroundColor = NSColor.white.cgColor
        textView.backgroundColor = NSColor.clear

//        destinationView.layer?.backgroundColor = NSColor.systemGreen.cgColor
//        destinationImageView.layer?.wantsLayer = true
//        destinationView.layer?.wantsLayer = true
        
        view.addGestureClick { (gesture) in
            self.showAlert()
        }
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        
        destinationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        textView.enclosingScrollView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(-10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(25)
        }
        
        destinationImageView.snp.makeConstraints { (make) in
            make.top.equalTo(textView.enclosingScrollView!.snp.bottom).offset(10)
            make.centerX.equalToSuperview().offset(0)
            make.width.equalTo(500)
            make.height.equalTo(500)
        }
                
//        destinationImageView.snp.makeConstraints { (make) in
//            make.top.equalTo(textView.enclosingScrollView!.snp.bottom).offset(10)
//            make.centerX.equalToSuperview().offset(10)
//            make.width.equalToSuperview().multipliedBy(0.7)
//            make.bottom.equalToSuperview().offset(-10)
//        }
        
    }
    
    func showAlert() {
        if showAlertAgain == false {
            return
        }
            
        NSAlert()
            .messageText("提示")
            .informativeText("非图片文件")
            .alertStyle(.warning)
//             .addButtons(["确定", "取消",])
            .addButtons(["确定",])
//            .showsHelp(true)
//            .showsSuppressionButton(true)
//            .suppressionButtonAction({ (sender) in
//                DDLog(sender.state.rawValue)
//                self.showAlertAgain = sender.state.rawValue == 0;
//            })
            .beginSheet { (respone) in
                print("\(#function)\(respone)")
            }
    }
    
}


@available(OSX 10.13, *)
extension DragFileController: DragDestinationViewDelegate {
    
    func processImage(_ image: NSImage, pasteBoard: NSPasteboard) {
        destinationImageView.image = image
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
            
            showAlert()

        case let value as NSColor:
            print(#function, #line, "NSColor", value)
            destinationImageView.layer?.backgroundColor = value.cgColor
            textView.textColor = value
            
        case let value as URL:
            print(#function, #line, "URL", value.absoluteString.removingPercentEncoding ?? "")
            textView.string = value.lastPathComponent.removingPercentEncoding ?? ""

            showAlert()

        default:
            print(#function, #line, obj)
            break
        }
    }
}
