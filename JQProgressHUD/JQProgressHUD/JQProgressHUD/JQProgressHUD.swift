//
//  JQProgressHUD.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/6/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

fileprivate struct Action {
    static let  removeToastAction = #selector(JQProgressHUD.removeToast(t:))
}

open class JQProgressHUD: UIView {
    
    // MARK: - property
    // translucent mask
    @objc public var isNeedMask: Bool = false {
        didSet {
            if isNeedMask {
                self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            }
            if isNeedShowAnimation {
                addAnimations(view: self)
            }
        }
    }
    
    @objc public var duration: TimeInterval = 3.0 {
        didSet {
            if isNeedShowAnimation {
                addAnimations(view: toastLabel)
            }
            addTimer(duration: duration)
        }
    }
    
    @objc public var containerViewBGcolor: UIColor? {
        didSet {
            containerView.backgroundColor = containerViewBGcolor
        }
    }
    
    public var containerViewRadius: CGFloat? = 8.0 {
        didSet {
            containerView.layer.cornerRadius = containerViewRadius!
        }
    }
    
    @objc public var containerViewSize: CGSize = CGSize.init(width: 65.0, height: 65.0) {
        didSet {
            containerView.frame = CGRect.init(x: 0, y: 0, width: containerViewSize.width, height: containerViewSize.height)
        }
    }
    
    @objc public var indicatorView: UIView! {
        didSet {
            for view in customIndicatorView.subviews {
                view.removeFromSuperview()
            }
            indicatorViewSize = indicatorView.bounds.size
            customIndicatorView.addSubview(indicatorView)
        }
    }
    
    @objc public var toastViewWidth: CGFloat = 0
    
    @objc public var isIndicatorViewLeft: Bool = false
    
    private var indicatorViewSize: CGSize = CGSize.init(width: 30.0, height: 30) {
        didSet {
            customIndicatorView.frame = CGRect.init(x: 0, y: 0, width: indicatorViewSize.width, height: indicatorViewSize.height)
        }
    }
    
    fileprivate var isNeedShowAnimation: Bool = false
    fileprivate var timer: Timer?
    fileprivate var pView: UIView?
    fileprivate var isToast: Bool = false

    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// convenience constructor
    convenience public init(view: UIView, isToast: Bool) {
        self.init(frame: view.bounds)
        self.isToast = isToast
        self.toastViewWidth = bounds.size.width / 2.0
        self.pView = view
        commitInit()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if isToast {
            adjustToastLabelFrame()
        }else {
            containerView.frame = CGRect.init(x: 0, y: 0, width: containerViewSize.width, height: containerViewSize.height)
            containerView.center = self.center
            adjustIndicatorViewFrame()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        removeTimer()
    }
    
    // MARK: - private methods
    private func addAnimations(view: UIView, duration: TimeInterval? = 0.3) {
        view.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
        let alpha = view.alpha
        view.alpha = 0.5
        UIView.animate(withDuration: duration!, animations: {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            view.alpha = alpha
            view.transform = CGAffineTransform.identity
        })
    }
    
    private func addTimer(duration: TimeInterval) {
        removeTimer()
        timer = JQWeakTimerObject.scheduledTimerWithTimeInterval(duration, aTargat: self, aSelector: Action.removeToastAction, userInfo: pView!, repeats: false)
        RunLoop.current.add(timer!, forMode: RunLoop.Mode.common)
        
    }
    
    fileprivate func removeTimer() {
        guard let _ = timer else {
            return
        }
        timer?.invalidate()
        timer = nil
    }
    
    private func commitInit() {
        registerForNotifications()
    }
    
    private func registerForNotifications() {
        
        NotificationCenter.default.addObserver(self, selector:#selector(statusBarOrientationDidChange(notification:)) , name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }
    
    @objc private func statusBarOrientationDidChange(notification: NSNotification) {
        
        guard let view = self.superview else { return }
        frame = view.bounds
    }
    
    private func adjustIndicatorViewFrame() {
        
        let textLength = detailLabel.text?.count ?? 0
        var customIndicatorViewX: CGFloat = 0
        var customIndicatorViewY: CGFloat = 0
        var detailLabelW: CGFloat = 0
        var detailLabelX: CGFloat = 0
        var detailLabelY: CGFloat = 0
        let detailLabelH: CGFloat = 18.0
        
        if textLength > 0 {
            
            if isIndicatorViewLeft {
                
                detailLabelW = (containerView.bounds.size.width - customIndicatorView.bounds.size.width - 13)
                customIndicatorViewX = 5
                customIndicatorViewY = (containerView.bounds.size.height - (customIndicatorView.frame.size.height)) / 2.0
                detailLabelX = customIndicatorViewX + customIndicatorView.bounds.size.width + 3
                detailLabelY = (containerView.bounds.size.height - detailLabelH) / 2.0
                detailLabel.textAlignment = .left
            
            }else {
                customIndicatorViewX = (containerView.bounds.size.width - customIndicatorView.bounds.size.width) / 2.0
                customIndicatorViewY = (containerView.bounds.size.height - (customIndicatorView.frame.size.height + detailLabelH)) / 2.0
                detailLabelW = containerView.bounds.size.width
                detailLabelY = customIndicatorView.frame.size.height + customIndicatorViewY + 3
                detailLabelX = 0
    
            }
            
            customIndicatorView.frame.origin.x = customIndicatorViewX
            customIndicatorView.frame.origin.y = customIndicatorViewY
            detailLabel.frame  = CGRect.init(x: detailLabelX, y: detailLabelY, width: detailLabelW, height: detailLabelH)

            
        }else {
            customIndicatorView.frame.origin.x = (containerView.bounds.size.width - customIndicatorView.bounds.size.width) / 2.0
            customIndicatorView.frame.origin.y = (containerView.bounds.size.height - customIndicatorView.bounds.size.height) / 2.0
        }

    }
    
    private func adjustToastLabelFrame() {
        
        let textLength = toastLabel.text?.count ?? 0
        if textLength > 0 {
            let height = (toastLabel.attributedText?.jq_heightWithConstrainedWidth(width: toastViewWidth))! + 16
                //jq_heightWithConstrainedWidth(width: toastViewWidth, font: toastLabel.font))! + 16.0
            toastLabel.frame = CGRect.init(x: (self.bounds.size.width - toastViewWidth) / 2.0 , y: toastLabel.frame.origin.y == 0 ? (self.bounds.size.height - height) / 2.0 : toastLabel.frame.origin.y, width: toastViewWidth, height: height)
        }
    }
    
    
    private func setupUI() {

        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        if isToast {
            addSubview(toastLabel)
        }else {
            addSubview(containerView)
            containerView.addSubview(customIndicatorView)
            containerView.addSubview(detailLabel)
        }
    }
    
    fileprivate var containerView: UIView = {
        let containerView: UIView = UIView.init()
        containerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8.0
        return containerView
    }()
    
    fileprivate var customIndicatorView: UIView = {
        let view: UIView = UIView.init()
        view.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        return view
    }()

    public var toastLabel: JQProgressHUDLabel = {
        let containerLabel: JQProgressHUDLabel = JQProgressHUDLabel.init()
        containerLabel.textColor = UIColor.white
        containerLabel.font = UIFont.systemFont(ofSize: 14)
        containerLabel.numberOfLines = 0
        containerLabel.layer.masksToBounds = true
        containerLabel.layer.cornerRadius = 8.0
        containerLabel.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        containerLabel.textAlignment = .center
        containerLabel.insets = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return containerLabel
    }()
    
    public var detailLabel: JQProgressHUDLabel = {
        let label: JQProgressHUDLabel = JQProgressHUDLabel.init()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.insets = UIEdgeInsets.init(top: 5, left: 5, bottom: 8, right: 5)
        return label
    }()
}

extension JQProgressHUD {
    
    public class func showHUD(addTo view: UIView, animation: Bool? = false) -> JQProgressHUD {
        _ = JQProgressHUD.hideHUD(fromView: view)
        let hud = JQProgressHUD.init(view: view, isToast: false)
        hud.isNeedShowAnimation = animation!
        view.addSubview(hud)
        return hud
    }
    
    public class func showToastHUD(addTo view: UIView, animation: Bool? = false) -> JQProgressHUD {
        _ = JQProgressHUD.hideHUD(fromView: view)
        let hud = JQProgressHUD.init(view: view, isToast: true)
        view.addSubview(hud)
        hud.isNeedShowAnimation = animation!
        return hud
    }
    
    @objc public class func hideHUD(fromView view: UIView ) -> Bool {
        guard let hud:JQProgressHUD = JQProgressHUD.getHUD(fromView: view) else {
            return false
        }
        hud.removeToast(t: nil)
        return true
    }
    
    @objc public class func getHUD(fromView view: UIView) -> JQProgressHUD? {
        for subview in view.subviews where subview is JQProgressHUD {
            return subview as? JQProgressHUD
        }
        return nil
    }
    
    @objc fileprivate func removeToast(t: Timer?) {
        removeTimer()
        guard let hud: JQProgressHUD = JQProgressHUD.getHUD(fromView: pView!) else {
            return
        }
        hud.removeFromSuperview()
    }
}


