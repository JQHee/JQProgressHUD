//
//  JQProgressHUD.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/6/30.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

fileprivate let KTOASTHUDTAG = 999999

fileprivate struct Action {
    static let  removeToastAction = #selector(JQProgressHUD.removeToast(t:))
}

class JQProgressHUD: UIView {
    
    // MARK: - 属性
    // 是否需要半透明遮罩
    var isNeedMask: Bool = false {
        didSet {
            if isNeedMask {
                self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
            }
            if isNeedShowAnimation {
                addAnimations(view: self)
            }
        }
    }
    
    var duration: TimeInterval = 3.0 {
        didSet {
            if isNeedShowAnimation {
                addAnimations(view: toastLabel)
            }
            addTimer(duration: duration)
            //3秒后消失
            //perform(Action.removeToastAction, with: pView!, afterDelay: duration)
        }
    }
    
    var itemSize: CGSize = CGSize.init(width: 60.0, height: 60.0)
    
    fileprivate var isNeedShowAnimation: Bool = false
    fileprivate var timer: Timer?
    // 承载当前view视图
    fileprivate var pView: UIView?
    fileprivate var isToast: Bool = false
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    /// 便利构造器
    convenience init(view: UIView, isToast: Bool) {
        self.init(frame: view.bounds)
        self.isToast = isToast
        self.pView = view
        commitInit()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if isToast {
            adjustToastLabelFrame()
        }else {
            containerView.frame = CGRect.init(x: 0, y: 0, width: itemSize.width, height: itemSize.height)
            containerView.center = self.center
            adjustIndicatorViewFrame()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        removeTimer()
        //print("deinit")
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
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
        
    }
    
    fileprivate func removeTimer() {
        guard let _ = timer else { return }
        timer?.invalidate()
        timer = nil
    }
    
    private func commitInit() {
        registerForNotifications()
    }
    
    // 注册通知当屏幕旋转调整frame
    private func registerForNotifications() {
        
        NotificationCenter.default.addObserver(self, selector:#selector(statusBarOrientationDidChange(notification:)) , name: NSNotification.Name.UIApplicationDidChangeStatusBarOrientation, object: nil)
    }
    
    // 接收通知调用的方法
    @objc private func statusBarOrientationDidChange(notification:NSNotification) {
        
        guard let view = self.superview else { return }
        frame = view.bounds
    }
    
    private func adjustIndicatorViewFrame() {
        
        let textLength = detailLabel.text?.characters.count ?? 0
        
        if textLength > 0 {
            activityIndicatorView.frame.origin.x = (containerView.bounds.size.width - activityIndicatorView.bounds.size.width) / 2.0
            activityIndicatorView.frame.origin.y = (containerView.bounds.size.height-(activityIndicatorView.frame.size.height + 18)) / 2.0
            
            detailLabel.frame  = CGRect.init(x: 0, y: activityIndicatorView.frame.size.height + activityIndicatorView.frame.origin.y, width: containerView.bounds.size.width, height: 18)
            
        }else {
            activityIndicatorView.frame.origin.x = (containerView.bounds.size.width - activityIndicatorView.bounds.size.width) / 2.0
            activityIndicatorView.frame.origin.y = (containerView.bounds.size.height - activityIndicatorView.bounds.size.height) / 2.0
        }
        

    }
    
    private func adjustToastLabelFrame() {
        
        let textLength = toastLabel.text?.characters.count ?? 0
        if textLength > 0 {
            let height = (toastLabel.text?.jq_heightWithConstrainedWidth(width: self.bounds.width * 0.5, font: toastLabel.font))! + 16.0
            toastLabel.frame = CGRect.init(x: self.bounds.size.width / 4.0 , y: toastLabel.frame.origin.y == 0 ? (self.bounds.size.height - height) / 2.0 : toastLabel.frame.origin.y, width: self.bounds.size.width * 0.5, height: height)
        }
    }
    
    private func setupUI() {

        self.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
        if isToast {
            addSubview(toastLabel)
        }else {
            addSubview(containerView)
            containerView.addSubview(activityIndicatorView)
            containerView.addSubview(detailLabel)
        }
    }
    
    // MARK: - lazy load
    fileprivate var activityIndicatorView: UIActivityIndicatorView = {
        let indicatorView: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        indicatorView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        indicatorView.startAnimating()
        return indicatorView
    }()
    
    fileprivate var containerView: UIView = {
        let containerView: UIView = UIView.init()
        containerView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        containerView.layer.masksToBounds = true
        containerView.layer.cornerRadius = 8.0
        return containerView
    }()
    
    open var toastLabel: JQProgressHUDLabel = {
        let containerLabel: JQProgressHUDLabel = JQProgressHUDLabel.init()
        containerLabel.textColor = UIColor.white
        containerLabel.font = UIFont.systemFont(ofSize: 14)
        containerLabel.numberOfLines = 2
        containerLabel.layer.masksToBounds = true
        containerLabel.layer.cornerRadius = 8.0
        containerLabel.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.9)
        containerLabel.textAlignment = .center
        containerLabel.insets = UIEdgeInsets.init(top: 8, left: 8, bottom: 8, right: 8)
        return containerLabel
    }()
    
    open var detailLabel: JQProgressHUDLabel = {
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
    
    class func showHUD(addTo view: UIView, animation: Bool? = false) -> JQProgressHUD {
        _ = JQProgressHUD.hideHUD(fromView: view, animation: false)
        let hud = JQProgressHUD.init(view: view, isToast: false)
        hud.isNeedShowAnimation = animation!
        view.addSubview(hud)
        return hud
    }
    
    class func showToastHUD(addTo view: UIView, animation: Bool? = false) -> JQProgressHUD {
        _ = JQProgressHUD.hideHUD(fromView: view, animation: false)
        let hud = JQProgressHUD.init(view: view, isToast: true)
        view.addSubview(hud)
        hud.isNeedShowAnimation = animation!
        hud.tag = KTOASTHUDTAG
        return hud
    }
    
    class func hideHUD(fromView view: UIView , animation: Bool) -> Bool {
        guard let hud:JQProgressHUD = JQProgressHUD.getHUD(fromView: view) else { return false}
        hud.removeToast(t: nil)
        return true
    }
    
    class func getHUD(fromView view: UIView) -> JQProgressHUD? {
        for subview in view.subviews where subview is JQProgressHUD {
            return subview as? JQProgressHUD
        }
        return nil
    }
    
    @objc fileprivate func removeToast(t: Timer?) {
        //NSObject.cancelPreviousPerformRequests(withTarget: self)
        removeTimer()
        guard let hud:JQProgressHUD = JQProgressHUD.getHUD(fromView: pView!) else { return }
        if hud.tag == KTOASTHUDTAG {
            hud.removeFromSuperview()
            
        }else {
            hud.removeFromSuperview()

        }
    }
}


