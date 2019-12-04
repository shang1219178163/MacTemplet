//
//  CABasicAnimation+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/3/29.
//  Copyright © 2019 BN. All rights reserved.
//

import QuartzCore

/// kCAMediaTimingFunction集合
public let kFunctionNames = [
                            CAMediaTimingFunctionName.linear,//匀速
                            CAMediaTimingFunctionName.easeIn,//先慢
                            CAMediaTimingFunctionName.easeOut,//后慢
                            CAMediaTimingFunctionName.easeInEaseOut,//先慢 后慢 中间快
                            CAMediaTimingFunctionName.default//默认
                            ];

@objc public extension CABasicAnimation{
    
    /// [源]CABasicAnimation
    static func animKeyPath(_ keyPath: String,
                                  duration: CFTimeInterval,
                                  autoreverses: Bool = false,
                                  repeatCount: Float,
                                  fillMode: CAMediaTimingFillMode = .forwards,
                                  removedOnCompletion: Bool = false,
                                  functionName: CAMediaTimingFunctionName = .linear) -> CABasicAnimation {
        
        let anim = CABasicAnimation(keyPath: keyPath)
        anim.duration = duration;
        anim.repeatCount = repeatCount;
        anim.fillMode = fillMode;
        anim.isRemovedOnCompletion = removedOnCompletion;
        
        let name = kFunctionNames.contains(functionName) ? functionName : kFunctionNames.first;
        anim.timingFunction = CAMediaTimingFunction(name: name!);
        anim.isCumulative = keyPath == kTransformRotationZ;
        return anim;
    }
    
    /// [便捷]CABasicAnimation
    static func animKeyPath(_ keyPath: String,
                                  duration: CFTimeInterval,
                                  autoreverses: Bool = false,
                                  repeatCount: Float,
                                  fromValue: Any,
                                  toValue: Any) -> CABasicAnimation {
        let anim = animKeyPath(keyPath, duration: duration, repeatCount: repeatCount, functionName: kFunctionNames.first!);
        anim.fromValue = fromValue;
        anim.toValue = toValue;
        return anim;
    }
    
}
