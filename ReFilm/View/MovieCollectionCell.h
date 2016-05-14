//
//  MovieCollectionCell.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieCollectionCell;

@protocol MovieCollectionCellDelegate <NSObject>

- (void)longPressedCellWith:(MovieCollectionCell *)cell;

@end


@interface MovieCollectionCell : UICollectionViewCell

@property (nonatomic, weak) id<MovieCollectionCellDelegate> delegate;

@property (nonatomic, strong) UIImageView *movieImage;

@property (nonatomic, strong) UILabel *movieTitleLabel;

@property (nonatomic, strong) UILabel *movieRatingLabel;

@property (nonatomic, strong) UILabel *actorLabel;


@end
