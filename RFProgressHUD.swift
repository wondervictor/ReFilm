//
//  RFProgressHUD.swift
//  ProgressHUD
//
//  Created by VicChan on 5/25/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

import UIKit

enum RFProgressHUDType {
    case RFProgressHUDTypeDefault, RFProgressHUDTypeError, RFProgressHUDTypeSuccess

}


public class RFProgressHUD: UIView {
    
    public var duration: Double = 3.0
    public var title: String?
    public var radius: CGFloat = 30.0
    public var progressSize: CGSize = CGSizeMake(100, 100)
    
    
    private var shapeLayer = CAShapeLayer()
    private var titleLabel = UILabel()
    private var imageView = UIImageView()
    private var shapePoint: CGPoint = CGPointMake(0, 0)
    private var progressView: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.shapePoint = CGPointMake(frame.size.height/2.0, frame.size.height/2.0 - 20)

    }
    
    init(frame: CGRect,radius: CGFloat, duration: Double) {
        super.init(frame: frame)
        self.duration = duration
        self.radius = radius
        self.frame = frame;
        self.shapePoint = CGPointMake(self.frame.size.height/2.0, self.frame.size.height/2.0 - 20)
        self.defaultState()
        print(shapePoint)
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 10;
    
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func defaultState() {
        let progressFrame = CGRectMake(0, 0, self.frame.size.height * 0.7, self.frame.size.height * 0.7)
    
        progressView = UIView(frame: progressFrame)
        progressView.backgroundColor = UIColor.clearColor()
        progressView.center = self.shapePoint
        let center = CGPointMake(progressFrame.size.width/2.0, progressFrame.size.height/2.0)

        let path = UIBezierPath(arcCenter: center, radius: self.radius, startAngle: 0, endAngle: 2 * CGFloat(M_PI), clockwise: true)
        shapeLayer.anchorPoint = CGPointMake(0.5, 0.5)
        shapeLayer.frame = CGRectMake(0, 0, progressFrame.size.height, progressFrame.size.height)
        shapeLayer.position = center
        
        print(shapeLayer.frame)
        print(shapeLayer.bounds)
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeEnd = 0.75
        shapeLayer.strokeStart = 0
        shapeLayer.lineWidth = 4.8
        shapeLayer.strokeColor = UIColor.lightGrayColor().CGColor
        shapeLayer.path = path.CGPath
        
        progressView.layer.addSublayer(self.shapeLayer)
        self.addSubview(progressView)
        
        titleLabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 20))
        titleLabel.font = UIFont(name: "HelveticaNeue-Light",size: 16)
        titleLabel.text = "网络超时"
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.lightGrayColor()
        titleLabel.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height - 15)
        self.addSubview(titleLabel)
    
    }
    
    public func startAnimating() {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        
        rotationAnimation.duration = Double(self.duration)
        rotationAnimation.toValue = CGFloat(2 * M_PI * duration)
        rotationAnimation.fromValue = 0
        rotationAnimation.repeatCount = HUGE
        
        self.shapeLayer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
        
        
    }
    
    public func stopAnimating() {
        
    }
    
    public func stopWithError(error: String) {
        
    }
    
    public func stopWithSuccess(success: String) {
        
    }
    
    
}

extension RFProgressHUD {
    
}

