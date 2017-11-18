//
//  test.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/2.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation

public class JQWeakTimerObject: NSObject {
    public weak var targat: AnyObject?
    public var selector: Selector?
    public var timer: Timer?
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
    @objc public func fire(_ ti: Timer) {
        if let _ = targat {
            _ = targat?.perform(selector!, with: ti.userInfo)
        } else {
            timer?.invalidate()
        }
    }
}
