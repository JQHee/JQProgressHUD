//
//  JQProgressHUDTool.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


open class JQProgressHUDTool: NSObject {

    @discardableResult
    public class func jq_showNormalHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",  isNeedmask: Bool? = false, isUserInteractionEnabled: Bool? = false, animation: Bool? = false) -> JQProgressHUD {
        
        let hud: JQProgressHUD = JQProgressHUD.showHUD(addTo: view!, animation: animation)
        hud.isNeedMask = isNeedmask!
        hud.detailLabel.text = msg!
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView(style: .white)
        activityIndicatorView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        activityIndicatorView.startAnimating()
        hud.indicatorView = activityIndicatorView
        hud.isUserInteractionEnabled = isUserInteractionEnabled!
        return hud
    }
    
    @discardableResult
    public class func jq_showCustomHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "", isNeedmask: Bool? = false, isUserInteractionEnabled: Bool? = false, animation: Bool? = false) -> JQProgressHUD {
        
        let hud: JQProgressHUD = JQProgressHUD.showHUD(addTo: view!, animation: animation!)
        hud.isNeedMask = isNeedmask!
        hud.detailLabel.text = msg!
        let indicatorView: JQIndicatorView = JQIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        indicatorView.color = UIColor.white
        hud.indicatorView = indicatorView
        hud.isUserInteractionEnabled = isUserInteractionEnabled!
        return hud
    }
    
    @discardableResult
    public class func jq_showCircularHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",progress: CGFloat? = 0, isNeedmask: Bool? = false, isUserInteractionEnabled: Bool? = false, animation: Bool? = false) -> JQProgressHUD {
        
        var  hud: JQProgressHUD
        hud = JQProgressHUD.showHUD(addTo: view!, animation: animation!)
        hud.isNeedMask = isNeedmask!
        hud.detailLabel.text = msg!
        let circularindicator = JQCircularIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        circularindicator.annularColor = UIColor.white
        circularindicator.textSize = 8
        circularindicator.progress = progress!
        hud.indicatorView = circularindicator
        hud.isUserInteractionEnabled = isUserInteractionEnabled!
        return hud
    }
    
    @discardableResult
    public class func jq_showOvalHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "", isNeedmask: Bool? = false, isUserInteractionEnabled: Bool? = false, animation: Bool? = false) -> JQProgressHUD {
        
        var  hud: JQProgressHUD
        hud = JQProgressHUD.showHUD(addTo: view!, animation: animation!)
        hud.isNeedMask = isNeedmask!
        hud.detailLabel.text = msg!
        let indicatorView = JQOvalIndicatorView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
        indicatorView.color = UIColor.white
        hud.indicatorView = indicatorView
        hud.isIndicatorViewLeft = true
        hud.containerViewSize = CGSize.init(width: 120, height: 35)
        hud.isUserInteractionEnabled = isUserInteractionEnabled!
        return hud
    }
    
    @discardableResult
    public class func jq_showImageHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",imageName: String? = "", isNeedmask: Bool? = false, isUserInteractionEnabled: Bool? = false, animation: Bool? = false) -> JQProgressHUD {
        
        let hud: JQProgressHUD = JQProgressHUD.showHUD(addTo: view!)
        hud.isNeedMask = isNeedmask!
        hud.detailLabel.text = msg!
        hud.duration = 3.0
        let imageView: UIImageView = UIImageView.init()
        imageView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        imageView.contentMode = UIView.ContentMode.center
        imageView.image = UIImage.init(named: imageName ?? "")
        hud.indicatorView = imageView
        hud.containerViewBGcolor = UIColor.orange
        hud.isUserInteractionEnabled = isUserInteractionEnabled!
        return hud
    }
    
    @discardableResult
    public class func jq_showToastHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",duration: TimeInterval? = 3.0, isUserInteractionEnabled: Bool? = false, animation: Bool? = false) -> JQProgressHUD {
        
        let hud: JQProgressHUD = JQProgressHUD.showToastHUD(addTo: view!, animation: animation!)
        hud.duration = duration!
        hud.toastLabel.text = msg
        hud.isUserInteractionEnabled = isUserInteractionEnabled!
        return hud
    }
    
    public class func jq_hideHUD(view: UIView? = UIApplication.shared.windows.last) {
        let _ = JQProgressHUD.hideHUD(fromView: view!)
    }
}
