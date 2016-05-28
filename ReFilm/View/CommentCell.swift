//
//  CommentCell.swift
//  ReFilm
//
//  Created by VicChan on 5/28/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

import UIKit

public class CommentCell: UITableViewCell {

    
    public var nameLabel: UILabel!
   
    
    public var commentLabel: UILabel!
    
    var width: CGFloat = 0.0
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.configureSubViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureSubViews() {
        self.nameLabel = UILabel();
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.contentView.addSubview(self.nameLabel)
        
        let nameConstraintTop = NSLayoutConstraint(
            item: self.nameLabel,
            attribute:.Top,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .Top,
            multiplier: 1,
            constant: 0)
        nameConstraintTop.active = true
        
        let nameConstraintLeft = NSLayoutConstraint(
            item: self.nameLabel,
            attribute:.Left,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .Left,
            multiplier: 1,
            constant: 15)
        nameConstraintLeft.active = true
       
        let nameConstraintRight = NSLayoutConstraint(
            item: self.nameLabel,
            attribute:.Right,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .Right,
            multiplier: 1,
            constant: -15)
        nameConstraintRight.active = true
        
        let nameConstraintHeight = NSLayoutConstraint(
            item: self.nameLabel,
            attribute:.Height,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .Height,
            multiplier: 0,
            constant: 20)
        nameConstraintHeight.active = true
        
        self.nameLabel.textColor = UIColor.orangeColor()
        self.nameLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        

        
        self.commentLabel = UILabel()
        self.commentLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.commentLabel)
        let commentTop = NSLayoutConstraint(
            item: self.commentLabel,
            attribute:.Top,
            relatedBy: .Equal,
            toItem: self.nameLabel,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        commentTop.active = true
        
        let commentLeft = NSLayoutConstraint(
            item: self.commentLabel,
            attribute:.Left,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .Left,
            multiplier: 1,
            constant: 15)
        commentLeft.active = true
        
        let commentRight = NSLayoutConstraint(
            item: self.commentLabel,
            attribute:.Right,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .Right,
            multiplier: 1,
            constant: -15)
        commentRight.active = true
        
        let commentBottom = NSLayoutConstraint(
            item: self.commentLabel,
            attribute:.Bottom,
            relatedBy: .Equal,
            toItem: self.contentView,
            attribute: .Bottom,
            multiplier: 1,
            constant: 0)
        commentBottom.active = true
        self.commentLabel.textColor = UIColor.blackColor()
        self.commentLabel.font = UIFont(name: "HelveticaNeue", size: 13)
        self.commentLabel.numberOfLines = 0

        
        
        /*
        CAShapeLayer *lineLayer = [CAShapeLayer layer];
        lineLayer.strokeColor = [UIColor greenColor].CGColor;
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 20);
        CGPathAddLineToPoint(path, NULL, MAIN_WIDTH-30, 20);
        lineLayer.path = path;
        CGPathRelease(path);
        [titleLabel.layer addSublayer:lineLayer];
        */
    }
    
    
    override public func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
