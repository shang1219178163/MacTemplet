//
//  NNViewCreater.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/1/11.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

/// 自定义视图
class NNViewCreater: NSObject {

    /// 获取类内容
    static func getContent(with name: String, type: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: type)
        return """
\(copyRight)
import UIKit

import SnapKit
import SwiftExpand
        
@objc protocol \(name)Delegate{
    
        @objc func \(name.lowercased())(_ rangeView: \(name))
}
        
///
class \(name): UIView {

    weak var delegate: \(name)Delegate?

    typealias ViewClick = (\(name), Int) -> Void;
    var viewBlock: ViewClick?;
    
    // MARK: -lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.height <= 0.0 {
            return;
        }
        
        
    }
    
    // MARK: - funtions
    func block(_ action: @escaping ViewClick) {
        self.viewBlock = action;
    }
    
        
    //MARK: - lazy
    lazy var btnCancell: UIButton = {
        let view = UIButton(type: .custom);
        view.tag = 0;
        
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        view.setTitle(kTitleCancell, for: .normal);
        view.setTitleColor(.lightGray, for: .normal);
        view.addActionHandler({ (control) in
            if let sender = control as? UIButton {
                self.viewBlock!(self,sender.tag);
                self.dismiss();
            }

        }, for: .touchUpInside)
        return view;
    }();
    
    lazy var label: UILabel = {
        let view = UILabel(frame: .zero);
        view.text = "请选择";
        view.textColor = .lightGray;
        view.textAlignment = .center;
        return view;
    }();
    
    lazy var btnSure: UIButton = {
        let view = UIButton(type: .custom);
        view.tag = 1;
        
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        view.setTitle(kTitleSure, for: .normal);
        view.setTitleColor(.systemBlue, for: .normal);
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
    /// 获取.h类内容
    static func getContentH(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "h")
        let prefix = name.getPrefix(with: ["View",])
        return """
\(copyRight)
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface \(prefix)View : UIView


@end

NS_ASSUME_NONNULL_END

"""
    }
    
    /// 获取.h类内容
    static func getContentM(with name: String) -> String {
        let copyRight = NSApplication.getCopyright(with: name, type: "m")
        let prefix = name.getPrefix(with: ["View",])
        return """
\(copyRight)
#import "\(prefix)View.h"


@interface \(prefix)View ()


@end

@implementation \(prefix)View

#pragma mark --Dealloc
- (void)dealloc{

}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {

        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];

    if (self.bounds.size.height <= 0) {
        return
    }
    
}
        
#pragma mark -funtions
        
        
#pragma mark -lazy
    

@end

"""
    }

}
