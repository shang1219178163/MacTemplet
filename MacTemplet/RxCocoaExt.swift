//
//  RxCocoaExt.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/1/4.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa


///事件间隔(毫秒)
public let kEventInterval: Int = 1500


class RxCocoaExt: NSObject {

}

public extension Reactive where Base: NSButton {
    var safeTap: ControlEvent<Void> {
        return ControlEvent.init(events: tap.throttle(.milliseconds(kEventInterval), latest: false, scheduler: MainScheduler.instance))
    }
    ///避免连续点击(1.5 秒响应一次)
    func safeDrive(onNext: @escaping ((Base) -> Void)) -> Disposable {
        return self.safeTap
            .asControlEvent()
            .asDriver()
            .drive {
                onNext(self.base)
            } onCompleted: {
                
            } onDisposed: {
                
            }
    }
}

public extension Reactive where Base: NSTextView {
    ///避免连续调用(1.5 秒响应一次)
    func safeDrive(_ dueTime: RxSwift.RxTimeInterval = .milliseconds(0), onNext: @escaping ((String) -> Void)) -> Disposable {
        return string
            .asDriver()
            .distinctUntilChanged()
            .debounce(dueTime)
            .drive(onNext: { (query) in
                onNext(query)
            }) {
                
            } onDisposed: {
                
            }
    }
}

public extension Reactive where Base: NSTextField {
    ///避免连续调用(1.5 秒响应一次)
    func safeDrive(_ dueTime: RxSwift.RxTimeInterval = .milliseconds(kEventInterval), onNext: @escaping ((String) -> Void)) -> Disposable {
        return text.orEmpty
            .asDriver()
            .distinctUntilChanged()
            .debounce(dueTime)
            .drive(onNext: { (query) in
                onNext(query)
            }) {
                
            } onDisposed: {
                
            }
    }
}


public extension NSButton{
    ///避免连续调用(1.5 秒响应一次)
    func rxDrive(onNext: @escaping ((NSButton) -> Void)) -> Disposable {
        return self.rx.safeDrive(onNext: onNext)
    }
}

public extension NSTextView{
    ///避免连续调用(1.5 秒响应一次)
    func rxDrive(onNext: @escaping ((String) -> Void)) -> Disposable {
        return self.rx.safeDrive(onNext: onNext)
    }
}

public extension NSTextField{
    ///避免连续调用(1.5 秒响应一次)
    func rxDrive(onNext: @escaping ((String) -> Void)) -> Disposable {
        return self.rx.safeDrive(onNext: onNext)
    }
}
