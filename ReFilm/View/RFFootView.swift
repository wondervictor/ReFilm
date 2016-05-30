//
//  RFHeadView.swift
//  ReFilm
//
//  Created by VicChan on 5/30/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

import UIKit

class RFFootView: UICollectionReusableView {
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        let titleLabel = UILabel(frame:CGRectMake(CGRectGetMidX(frame)-100,0,200,30))
        titleLabel.textColor = UIColor.lightGrayColor()
        titleLabel.text = "电影信息来源于 豆瓣电影";
        titleLabel.textAlignment = .Center
        self.addSubview(titleLabel)
        
        let imageView = UIImageView(frame: CGRectMake(CGRectGetMidX(frame)-20, 30, 40, 40))
        imageView.image = UIImage(named: "douban")
        imageView.contentMode = .ScaleAspectFit
        self.addSubview(imageView)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    
}
