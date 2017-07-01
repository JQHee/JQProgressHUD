//
//  JQHUDString-Extension.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/1.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func jq_heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return boundingBox.height
    }
}

extension NSAttributedString {
    
    func jq_heightWithConstrainedWidth(width: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, context: nil)
        return ceil(boundingBox.height)
    }
}
