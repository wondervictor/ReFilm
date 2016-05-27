//
//  ComingMovieViewCell.swift
//  ReFilm
//
//  Created by VicChan on 5/27/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

import UIKit

public class ComingMovieViewCell: UICollectionViewCell {
    
    public var titleLabel: UILabel!
    public var movieImageView: UIImageView!
    
    override init(frame: CGRect) {
        movieImageView = UIImageView(frame: frame)
        super.init(frame: frame)
        self.configureSubViews()
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureSubViews() {
        self.movieImageView.frame = self.contentView.bounds
        self.contentView.addSubview(self.movieImageView)
        
        let visualEffect = UIBlurEffect(style: .Light)
        let visualView = UIVisualEffectView(effect: visualEffect)
        
        self.movieImageView.addSubview(visualView)
        visualView.translatesAutoresizingMaskIntoConstraints = false
        let visualViewLeft = NSLayoutConstraint(
            item: visualView,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: self.movieImageView,
            attribute: .Left,
            multiplier: 1,
            constant: 0)
        visualViewLeft.active = true
        
        let visualViewRight = NSLayoutConstraint(
            item: visualView,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: self.movieImageView,
            attribute: .Right,
            multiplier: 1,
            constant: 0)
        visualViewRight.active = true
        
        let visualViewHeight = NSLayoutConstraint(
            item: visualView,
            attribute: .Height,
            relatedBy: .Equal,
            toItem: nil,
            attribute: .Height,
            multiplier: 1,
            constant: 50)
        visualViewHeight.active = true

        let visualViewBottom = NSLayoutConstraint(
            item: visualView,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self.movieImageView,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        visualViewBottom.active = true
        self.titleLabel = UILabel(frame: CGRectMake(0, 0, 100, 40))
        visualView.addSubview(self.titleLabel)
        

        
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
       
        let titleLeft = NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Left,
            relatedBy: .Equal,
            toItem: visualView,
            attribute: .Left,
            multiplier: 1,
            constant: 10)
        titleLeft.active = true
        
        let titleRight = NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Right,
            relatedBy: .Equal,
            toItem: visualView,
            attribute: .Right,
            multiplier: 1,
            constant: 0)
        titleRight.active = true
        
        let titleTop = NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Top,
            relatedBy: .Equal,
            toItem: visualView,
            attribute: .Top,
            multiplier: 1,
            constant: 0)
        titleTop.active = true
        
        
        let titleBottom = NSLayoutConstraint(
            item: self.titleLabel,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: visualView,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        titleBottom.active = true
        
        self.titleLabel.font = UIFont(name:"HelveticaNeue-Medium", size: 14 )
        self.titleLabel.numberOfLines = 2
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.textColor = UIColor.blackColor()
        
    }
    
    
    
    
    
}
