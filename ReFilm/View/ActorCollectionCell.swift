//
//  ActorCollectionCell.swift
//  ReFilm
//
//  Created by VicChan on 5/26/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

import UIKit

public class ActorCollectionCell: UICollectionViewCell {
    
    public var imageView: UIImageView!
    public var nameLabel: UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.configureSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSubViews() {
        self.imageView = UIImageView(frame: CGRectMake(0, 0, 90, 120))
        self.imageView.center = CGPointMake(self.frame.size.width/2.0 , (self.frame.size.height-30)/2.0)
        self.contentView.addSubview(self.imageView)
        /*
        let imageViewConstraintTop = NSLayoutConstraint(item: self.imageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.contentView, attribute: .Top, multiplier: 1, constant: 5)
        self.contentView.addConstraint(imageViewConstraintTop)
        let imageViewConstrainLeft = NSLayoutConstraint(item: self.imageView, attribute: .Left, relatedBy: .Equal, toItem: self.contentView, attribute: .Left, multiplier: 1, constant: 5)
        self.contentView.addConstraint(imageViewConstrainLeft)
        
        let imageViewConstrainRight = NSLayoutConstraint(item: self.imageView, attribute: .Right, relatedBy: .Equal, toItem: self.contentView, attribute: .Right, multiplier: 1, constant: -5)
        self.contentView.addConstraint(imageViewConstrainRight)
        
        self.contentView .addConstraint(NSLayoutConstraint(item: self.imageView, attribute: .Bottom, relatedBy: .Equal, toItem: self.contentView, attribute: .Bottom, multiplier: 1, constant:  -30))
 */
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        self.nameLabel = UILabel(frame: CGRectMake(0,0,self.frame.size.width,30))
        self.nameLabel.center = CGPointMake(self.frame.size.width/2.0, self.frame.size.height-15);
        self.nameLabel.font = UIFont(name: "HelveticaNeue",size: 12)

        self.nameLabel.textAlignment = .Center
        self.addSubview(self.nameLabel)
       
        
        
    }
    
    
    
}
