//
//  JQIndicatorView.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/3.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

open class JQIndicatorView: UIView {

    public var color: UIColor? = UIColor.white {
        didSet{
            commonInit()
        }
    }
    
    private let lineWidth: CGFloat = 2.0
    private let radius: CGFloat = 10.0
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods
    private func setupUI() {
    
        layer.addSublayer(gradientLayer)
        commonInit()
        startAnimation()
    }
    
    private func commonInit() {
        gradientLayer.colors = [color!.cgColor ,color!.cgColor]
        
        // mask
        indicatorLayer.fillColor = UIColor.clear.cgColor
        indicatorLayer.strokeColor = UIColor.black.cgColor
        indicatorLayer.lineWidth = lineWidth
        indicatorLayer.lineCap = CAShapeLayerLineCap.round
        
        // path
        let startAngle: CGFloat = 0
        let endAngle = CGFloat.pi / 2.0 * 3
        let arcCenter = CGPoint(x: gradientLayer.frame.size.width/2,
                                y :gradientLayer.frame.size.height/2)
        let path = UIBezierPath(arcCenter: arcCenter,
                                radius: radius,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        indicatorLayer.path = path.cgPath
        gradientLayer.mask = indicatorLayer
    }
    
    // MARK: - lazy load
    fileprivate lazy var indicatorLayer: CAShapeLayer = {
        
        let indicatorLayer = CAShapeLayer()
        return indicatorLayer
    }()
    
    fileprivate lazy var gradientLayer: CAGradientLayer = {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [self.color!.cgColor ,UIColor.white.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        
        let gradientLayerCenter = CGPoint(x: self.frame.size.width/2 - self.radius,
                                          y: self.frame.size.height/2 - self.radius)
        
        gradientLayer.frame = CGRect(x: gradientLayerCenter.x,
                                     y: gradientLayerCenter.y,
                                     width: self.radius * 2 + self.lineWidth,
                                     height: self.radius * 2 + self.lineWidth)
        return gradientLayer
    }()
    
    fileprivate func startAnimation() {
        
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber.init(value: Double(Double.pi * 2.0))
        animation.duration = 1.0
        animation.repeatCount = MAXFLOAT
        animation.isRemovedOnCompletion = true
        gradientLayer.add(animation, forKey: "rotationAnimation")
    }

}
