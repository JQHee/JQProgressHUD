//
//  JQProgressHUDLabel.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

open class JQProgressHUDLabel: UILabel {

    public var insets: UIEdgeInsets?
    
    override  open func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: self.insets!))
    }

}
