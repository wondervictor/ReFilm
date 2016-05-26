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
    
    private var isAnimating = false
    private var shapeLayer = CAShapeLayer()
    private var titleLabel = UILabel()
    private var imageView = UIImageView()
    private var shapePoint: CGPoint = CGPointMake(0, 0)
    private var progressView: UIView!
    private var parentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.shapePoint = CGPointMake(frame.size.height/2.0, (self.frame.size.height - 30)/2.0 )

    }
    
    init(frame: CGRect,radius: CGFloat, duration: Double, parentView: UIView) {
        super.init(frame: frame)
        self.duration = duration
        self.radius = radius
        self.frame = frame;
        self.parentView = parentView
        self.shapePoint = CGPointMake(self.frame.size.height/2.0, (self.frame.size.height - 30)/2.0 )
        self.defaultState()
        print(shapePoint)
        self.backgroundColor = UIColor.whiteColor()
        self.layer.cornerRadius = 15;
    
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
        shapeLayer.lineWidth = 3.5
        shapeLayer.strokeColor = UIColor.blackColor().CGColor
        shapeLayer.path = path.CGPath
        
        progressView.layer.addSublayer(self.shapeLayer)
        
        titleLabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width - 20, 20))
        titleLabel.font = UIFont(name: "HelveticaNeue",size: 14)
        titleLabel.text = "正在加载..."
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.blackColor()
        titleLabel.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height - 20)
        self.addSubview(titleLabel)
    
    }
    
    public func startAnimating() {
        self.addSubview(progressView)
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.duration = Double(self.duration)
        rotationAnimation.toValue = CGFloat(2 * M_PI * self.duration)
        rotationAnimation.fromValue = 0
        rotationAnimation.repeatCount = HUGE
        isAnimating = true
        if let parentView = self.parentView {
            self.alpha = 0
            parentView.addSubview(self)
            UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseInOut, animations: {
                self.alpha = 1
                self.shapeLayer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
                }, completion: { (isFinished) in

            })
        }
        
    }
    
    public func startAnimatingWithTitile(title: String) {
        self.titleLabel.text = title
        self.startAnimating()
    }
    
    public func stopAnimating() {
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {
            self.alpha = 0
            }) { (isFinished) in
                self.isAnimating = false
                self.shapeLayer.removeAnimationForKey("rotationAnimation")
                self.removeFromSuperview()
        }
        
    }
    
    public func stopWithError(error: String) {
        let imageFrame = CGRectMake(0, 0, self.frame.size.height * 0.4, self.frame.size.height * 0.4)
        self.imageView = UIImageView(frame: imageFrame)
        self.imageView.center = self.shapePoint
        imageView.image = UIImage(named: "error")
        titleLabel.text = error
        self.shapeLayer.removeAnimationForKey("rotationAnimation")
        self.progressView.removeFromSuperview()
        self.addSubview(self.imageView)
        if isAnimating == false {
            self.showImageState()
        }
        self.dismiss()
    
        
    }
    
    private func showImageState() {
        self.alpha = 0
        self.parentView?.addSubview(self)
        UIView.animateWithDuration(0.4, animations: { 
            self.alpha = 1
            }) { (isFinished) in
        }
    }
    
    
    internal func dismiss() {
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) {
            UIView.animateWithDuration(0.6, delay: 0, options: .CurveEaseInOut, animations: {
                self.alpha = 0.01
            }) { (isFinished) in
                self.isAnimating = false
                self.imageView.removeFromSuperview()
                self.removeFromSuperview()
            }
        }
        

    }
    
    
    public func stopWithSuccess(success: String) {
        
        let imageFrame = CGRectMake(0, 0, self.frame.size.height * 0.4, self.frame.size.height * 0.4)
        self.imageView = UIImageView(frame: imageFrame)
        self.imageView.center = self.shapePoint
        imageView.image = UIImage(named: "success")
        titleLabel.text = success
        self.shapeLayer.removeAnimationForKey("rotationAnimation")
        self.progressView.removeFromSuperview()
        self.addSubview(self.imageView)
        if isAnimating == false {
            self.showImageState()
        }
        self.dismiss()

    }
    
    
}

extension RFProgressHUD {
    
}

