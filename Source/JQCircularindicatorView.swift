//
//  JQCircularindicatorView.swift
//  JQProgressHUD
//
//  Created by HJQ on 2017/7/3.
//  Copyright © 2017年 HJQ. All rights reserved.
//

import UIKit

open class JQCircularIndicatorView: UIView {

    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        configParams()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var progress: CGFloat = 0 {
        didSet{
            setProgress(progress: progress)
        }
    }
    
    public var textSize: CGFloat = 15 {
        didSet{
            progressLabel.font = UIFont.systemFont(ofSize: textSize)
        }
    }
    
    public var annularColor: UIColor = UIColor.white  {
        didSet{
            progressLabel.textColor = annularColor
            annularLayer.strokeColor = annularColor.cgColor
        }
    }
    
    public var labelVisible = true {
        didSet{
            if !labelVisible { progressLabel.removeFromSuperview() }
        }
    }
    

    // MARK: - private methods
    fileprivate func configParams() {
        
        progressLabel.text = "0%"
        lineWidth = frame.size.height < frame.size.width ? frame.size.height / 20 : frame.size.width / 20
        let greaterWidth = frame.size.height < frame.size.width
        let greaterWidthRadius = frame.size.height / 2 - lineWidth / 2
        let greaterHeightRadius = frame.size.width / 2 - lineWidth / 2
        radius = greaterWidth ? greaterWidthRadius : greaterHeightRadius
        
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.strokeColor = UIColor.gray.cgColor
        backgroundLayer.lineWidth = lineWidth
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        
        annularLayer.fillColor = UIColor.clear.cgColor
        annularLayer.strokeColor = annularColor.cgColor
        annularLayer.lineWidth = lineWidth
        annularLayer.lineCap = CAShapeLayerLineCap.round
    }
    
    fileprivate func setupUI(){
        
        // 绘制 path
        let startAngle: CGFloat = 0
        let endAngle = CGFloat.pi * 2.0
        let arcCenter = CGPoint(x: frame.size.width/2,
                                y: frame.size.height/2)
        let path = UIBezierPath(arcCenter: arcCenter,
                                radius: radius ,
                                startAngle: startAngle,
                                endAngle: endAngle,
                                clockwise: true)
        backgroundLayer.path = path.cgPath
        layer.addSublayer(backgroundLayer)
        
        addSubview(progressLabel)
    }
    
    override open func layoutSubviews() {
        
        // 设置 progressLabel 的frame
        let radiusMinusHalfLineWidth = radius - lineWidth/2
        let squaredrmhlw = radiusMinusHalfLineWidth * radiusMinusHalfLineWidth
        let pw = 2 * squaredrmhlw
        progressLabel.frame.size = CGSize(width: sqrt(pw), height: sqrt(pw))
        progressLabel.center = CGPoint(x: frame.size.width/2,
                                       y: frame.size.height/2)
    }
    
    
    fileprivate func setProgress(progress: CGFloat) {
        
        if 0 <= progress && progress <= 100.0 {
            
            let startAngle: CGFloat = -(CGFloat.pi / 2.0)
            let endAngle = CGFloat.pi * 1.5
            let arcCenter = CGPoint(x: frame.size.width/2,
                                    y: frame.size.height/2)
            
            let path = UIBezierPath(arcCenter: arcCenter,
                                    radius: radius ,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            
            annularLayer.path = path.cgPath
            layer.addSublayer(annularLayer)
            annularLayer.strokeEnd = progress / 100
            progressLabel.text = "\(progress)%"
        }
    }
    
    // MARK: - lazy load
    fileprivate var progressLabel: UILabel = {
        let progressLabel = UILabel()
        progressLabel.textAlignment = NSTextAlignment.center
        return progressLabel
    }()
    
    fileprivate var lineWidth: CGFloat!
    
    fileprivate var radius: CGFloat!
    
    fileprivate lazy var backgroundLayer: CAShapeLayer = {
        let backgroundLayer = CAShapeLayer()
        return backgroundLayer
    }()
    
    fileprivate lazy var annularLayer: CAShapeLayer = {
        let annularLayer = CAShapeLayer()
        return annularLayer
    }()


}
