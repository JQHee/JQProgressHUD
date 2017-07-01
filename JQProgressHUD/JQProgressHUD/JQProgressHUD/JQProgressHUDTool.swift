//
//  JQProgressHUDTool.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

class JQProgressHUDTool: NSObject {

    
    class func jq_showHUD(view: UIView? = UIApplication.shared.windows.last, msg: String? = "", needMask: Bool? = false) {
        let hud: JQProgressHUD = JQProgressHUD.showHUD(addTo: view!)
        hud.isNeedMask = needMask!
        hud.detailLabel.text = msg
        hud.isUserInteractionEnabled = needMask!
        
        
    }
    
    class func jq_showToast(view: UIView? = UIApplication.shared.windows.last, msg: String? = "",duration: TimeInterval? = 3.0) {
        let hud: JQProgressHUD = JQProgressHUD.showToastHUD(addTo: view!)
        hud.duration = duration!
        hud.toastLabel.text = msg
        hud.isUserInteractionEnabled = false
        
    }
    
    class func jq_hideHUD(view: UIView? = UIApplication.shared.windows.last, animation: Bool? = false) {
        let _ = JQProgressHUD.hideHUD(fromView: view!, animation: animation!)
    }
}
