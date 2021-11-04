//
//  NSGestureRecognizer+Rx.swift
//  MacTemplet
//
//  Created by Bin Shang on 2021/1/4.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

//#if os(iOS) || os(tvOS)
//
//import UIKit
//import RxSwift
//
//// This should be only used from `MainScheduler`
//final class GestureTarget<Recognizer: NSGestureRecognizer>: RxTarget {
//    typealias Callback = (Recognizer) -> Void
//
//    let selector = #selector(ControlTarget.eventHandler(_:))
//
//    weak var gestureRecognizer: Recognizer?
//    var callback: Callback?
//
//    init(_ gestureRecognizer: Recognizer, callback: @escaping Callback) {
//        self.gestureRecognizer = gestureRecognizer
//        self.callback = callback
//
//        super.init()
//
//        gestureRecognizer.addTarget(self, action: selector)
//
//        let method = self.method(for: selector)
//        if method == nil {
//            fatalError("Can't find method")
//        }
//    }
//
//    @objc func eventHandler(_ sender: NSGestureRecognizer) {
//        if let callback = self.callback, let gestureRecognizer = self.gestureRecognizer {
//            callback(gestureRecognizer)
//        }
//    }
//
//    override func dispose() {
//        super.dispose()
//
//        self.gestureRecognizer?.removeTarget(self, action: self.selector)
//        self.callback = nil
//    }
//}
//
//extension Reactive where Base: NSGestureRecognizer {
//
//    /// Reactive wrapper for gesture recognizer events.
//    public var event: ControlEvent<Base> {
//        let source: Observable<Base> = Observable.create { [weak control = self.base] observer in
//            MainScheduler.ensureRunningOnMainThread()
//
//            guard let control = control else {
//                observer.on(.completed)
//                return Disposables.create()
//            }
//
//            let observer = GestureTarget(control) { control in
//                observer.on(.next(control))
//            }
//
//            return observer
//        }.take(until: deallocated)
//
//        return ControlEvent(events: source)
//    }
//
//}
//
//extension Reactive where Base : NSClickGestureRecognizer {
//
//    /// Reactive wrapper for gesture recognizer events.
//    public var event: RxCocoa.ControlEvent<Base>
//}
//
//public extension Reactive where Base: NSClickGestureRecognizer {
//    var safeEvent: ControlEvent<Base> {
//        return ControlEvent.init(events: event.throttle(.milliseconds(1500), latest: false, scheduler: MainScheduler.instance))
//    }
//
//    ///避免连续点击(1.5 秒响应一次)
//    func safeDrive(onNext: @escaping ((Base) -> Void)) -> Disposable {
//        return self.safeEvent
//            .asControlEvent()
//            .asDriver()
//            .drive(onNext: { (tap) in
//                onNext(self.base)
//
//            }, onCompleted: {
//
//            }, onDisposed: {
//
//            })
//    }
//}
//
//
//public extension NSView{
//    ///避免连续调用(1.5 秒响应一次)
//    func rxTap(onNext: @escaping ((NSClickGestureRecognizer) -> Void)) -> Disposable {
//        let tap = NSClickGestureRecognizer()
//        self.addGestureClick(tap)
//
////        return tap.rx.event.subscribe { (tap) in
////            onNext(tap)
////        }
//        return tap.rx.safeDrive(onNext: onNext)
//    }
//}
//
//#endif



