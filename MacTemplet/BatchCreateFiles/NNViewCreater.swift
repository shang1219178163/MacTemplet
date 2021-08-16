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
        let copyRight = NSApplication.copyright(with: name, type: type)
        return """
\(copyRight)
import UIKit
import SnapKit
import SwiftExpand
        
@objc protocol \(name)Delegate{
    @objc func \(name)(_ view: \(name))
    
}
        
///
@objcMembers class \(name): UIView {

    weak var delegate: \(name)Delegate?

    var block: ((\(name), Int) -> Void)?
    
    var inset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)

    // MARK: -lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if bounds.height <= 10.0 {
            return;
        }
        
    }
    
    // MARK: - funtions
    func show(_ animated: Bool = true) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        
        keyWindow.endEditing(true)
        keyWindow.addSubview(self);
//        self.transform = self.transform.scaledBy(x: 1.5, y: 1.5)
        let duration = animated ? 0.15 : 0
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.7);
            self.transform = CGAffineTransform.identity
            
        }, completion: nil);
    }

    func dismiss(_ animated: Bool = true) {
        let duration = animated ? 0.15 : 0
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0);
//            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)

        }) { (isFinished) in
            self.removeFromSuperview();
        }
    }
        
    //MARK: -lazy
    lazy var imgView: UIImageView = {
        var view = UIImageView(frame: .zero);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.image = UIImage(named: "icon_avatar")
        
        return view;
    }()
    
    lazy var label: UILabel = {
        let view = UILabel(frame: .zero);
        view.text = "请选择";
        view.textColor = .lightGray;
        view.textAlignment = .center;
        return view;
    }()
    
    lazy var btnSure: UIButton = {
        let view = UIButton(type: .custom);
        view.setTitle(kTitleSure, for: .normal);
        view.setTitleColor(.systemBlue, for: .normal);
        view.titleLabel?.font = UIFont.systemFont(ofSize: 16);
        view.adjustsImageWhenHighlighted = false;
        view.tag = 1;

        view.addActionHandler({ (sender) in
            self.viewBlock?(self, sender.tag);

        }, for: .touchUpInside)
        return view;
    }()
}

"""
    }
    /// 获取.h类内容
    static func getContentH(with name: String) -> String {
        let copyRight = NSApplication.copyright(with: name, type: "h")
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
        let copyRight = NSApplication.copyright(with: name, type: "m")
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

    if (self.bounds.size.height <= 10) {
        return
    }
    
}
        
#pragma mark -funtions
        
        
#pragma mark -lazy
    

@end

"""
    }

}
