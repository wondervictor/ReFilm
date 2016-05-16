//
//  MovieCollectionCell.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieCollectionCell;



@interface MovieCollectionCell : UICollectionViewCell


@property (nonatomic, strong) UIImageView *movieImage;

@property (nonatomic, strong) UILabel *movieTitleLabel;

@property (nonatomic, strong) UILabel *movieRatingLabel;

@property (nonatomic, strong) UILabel *actorLabel;


@end
