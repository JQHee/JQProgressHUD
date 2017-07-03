//
//  JQProgressHUDTool.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit


public class JQProgressHUDTool: NSObject {

    public class func jq_showNormalHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "", needMask: Bool? = false) {
        
        let hud: JQProgressHUD = JQProgressHUD.showHUD(addTo: view!)
        hud.isNeedMask = needMask!
        hud.detailLabel.text = msg!
        let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicatorView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        activityIndicatorView.startAnimating()
        hud.indicatorView = activityIndicatorView
        hud.isUserInteractionEnabled = needMask!
    }
    
    public class func jq_showCustomHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "", needMask: Bool? = false){
        
        let hud: JQProgressHUD = JQProgressHUD.showHUD(addTo: view!)
        hud.isNeedMask = needMask!
        hud.detailLabel.text = msg!
        let indicatorView: JQIndicatorView = JQIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 30))
        indicatorView.color = UIColor.white
        hud.indicatorView = indicatorView
        hud.isUserInteractionEnabled = needMask!
    }
    
    public class func jq_showCircularHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",progress: CGFloat? = 0, needMask: Bool? = false) {
        
        var  hud: JQProgressHUD
        hud = JQProgressHUD.showHUD(addTo: view!)
        hud.isNeedMask = needMask!
        hud.detailLabel.text = msg!
        let circularindicator = JQCircularindicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        circularindicator.annularColor = UIColor.white
        circularindicator.textSize = 8
        circularindicator.progress = progress!
        hud.indicatorView = circularindicator
        hud.isUserInteractionEnabled = needMask!
    }
    
    public class func jq_showImageHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",imageName: String? = "", needMask: Bool? = false) {
        
        let hud: JQProgressHUD = JQProgressHUD.showHUD(addTo: view!)
        hud.isNeedMask = needMask!
        hud.detailLabel.text = msg!
        hud.duration = 3.0
        let imageView: UIImageView = UIImageView.init()
        imageView.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        imageView.contentMode = UIViewContentMode.center
        imageView.image = UIImage.init(named: imageName ?? "")
        hud.indicatorView = imageView
        hud.containerViewBGcolor = UIColor.orange
        hud.isUserInteractionEnabled = needMask!
    }
    
    public class func jq_showToastHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",duration: TimeInterval? = 3.0) {
        
        let hud: JQProgressHUD = JQProgressHUD.showToastHUD(addTo: view!)
        hud.duration = duration!
        hud.toastLabel.text = msg
        hud.isUserInteractionEnabled = false
    }
    
    public class func jq_hideHUD(view: UIView? = UIApplication.shared.windows.last) {
        let _ = JQProgressHUD.hideHUD(fromView: view!)
    }
}
