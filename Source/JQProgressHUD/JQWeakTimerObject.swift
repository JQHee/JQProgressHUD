//
//  test.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/2.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

/// 自定义一个类，在类中添加一个方法返回对象类型为NSTimer，使用定时器时就用该对象创建，让NSTimer对这个对象进行强引用，而不对视图控制器进行强引用
class JQWeakTimerObject: NSObject {
    weak var targat: AnyObject?
    var selector: Selector?
    var timer: Timer?
    public static func scheduledTimerWithTimeInterval(_ interval: TimeInterval,
                                               aTargat: AnyObject,
                                               aSelector: Selector,
                                               userInfo: AnyObject?,
                                               repeats: Bool) -> Timer {
        let weakObject      = JQWeakTimerObject()
        weakObject.targat   = aTargat
        weakObject.selector = aSelector
        weakObject.timer    = Timer.scheduledTimer(timeInterval: interval,
                                                   target: weakObject,
                                                   selector: #selector(fire),
                                                   userInfo: userInfo,
                                                   repeats: repeats)
        return weakObject.timer!
    }
    public func fire(_ ti: Timer) {
        if let _ = targat {
            _ = targat?.perform(selector!, with: ti.userInfo)
        } else {
            timer?.invalidate()
        }
    }
}
