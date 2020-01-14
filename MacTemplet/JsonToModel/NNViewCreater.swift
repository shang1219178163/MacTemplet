//
//  NNViewCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/11.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

class NNViewCreater: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        return """
\(copyRight)

import UIKit

import SnapKit
import SwiftExpand
        
///
class \(name): UIView {

    
    typealias ViewClick = (\(name), Int) -> Void;
    var viewBlock: ViewClick?;
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        
    }
    
    // MARK: - funtions
    func block(_ action:@escaping ViewClick) {
        self.viewBlock = action;
    }
    
        
    //MARK: - lazy
    lazy var btnCancell:UIButton = {
        let view = UIButton(type: .custom);
        view.tag = 0;
        
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        view.setTitle(kTitleCancell, for: .normal);
        view.setTitleColor(UIColor.red, for: .normal);
        view.addActionHandler({ (control) in
            if let sender = control as? UIButton {
                self.viewBlock!(self,sender.tag);
                self.dismiss();
            }

        }, for: .touchUpInside)
        return view;
    }();
    
    lazy var label:UILabel = {
        let view = UILabel(frame: .zero);
        view.text = "请选择";
        view.textColor = UIColor.gray;
        view.textAlignment = .center;
        return view;
    }();
    
    lazy var btnSure:UIButton = {
        let view = UIButton(type: .custom);
        view.tag = 1;
        
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        view.setTitle(kTitleSure, for: .normal);
        view.setTitleColor(UIColor.theme, for: .normal);
        view.addActionHandler({ (control) in
            if let sender = control as? UIButton {
                self.viewBlock!(self,sender.tag);
            }

        }, for: .touchUpInside)
        return view;
    }();
}

"""
    }
}
