//
//  MovieCollectionCell.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "MovieCollectionCell.h"
#import <Masonry.h>

#define MAIN_WIDTH   (self.frame.size.width)
#define MAIN_HEIGHT  (self.frame.size.height)

@interface MovieCollectionCell()

@end

@implementation MovieCollectionCell

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {

        [self configureSubViews];
        
    }
    return self;
}

- (void)configureSubViews {
    
    self.movieImage = [[UIImageView alloc]initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.movieImage];
    
    UIVisualEffectView *viusalView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect new]];
    [self.movieImage addSubview:viusalView];
    
    [viusalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@80);
    }];
    
    self.movieTitleLabel = [UILabel new];
    [viusalView addSubview:self.movieTitleLabel];
    [self.movieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viusalView.mas_left).with.offset(3);
        make.right.equalTo(viusalView.mas_right).with.offset(-3);
        make.top.equalTo(viusalView.mas_top);
        make.height.equalTo(@30);
    }];
    self.movieRatingLabel.adjustsFontSizeToFitWidth = YES;
    
    self.movieRatingLabel = [UILabel new];
    [viusalView addSubview:self.movieRatingLabel];
    [self.movieRatingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@50);
        make.top.equalTo(self.movieTitleLabel.mas_bottom);
        make.right.equalTo(viusalView.mas_right);
        make.width.equalTo(@50);
    }];
    self.movieRatingLabel.textAlignment = NSTextAlignmentCenter;
    
    

    
    self.actorLabel = [UILabel new];
    [viusalView addSubview:self.actorLabel];
    [self.actorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(viusalView.mas_left).with.offset(5);
        make.right.equalTo(self.movieRatingLabel.mas_left).with.offset(-3);
        make.top.equalTo(self.movieTitleLabel.mas_bottom).with.offset(5);
        make.bottom.equalTo(viusalView.mas_bottom).with.offset(-5);
    }];
    self.actorLabel.font = [UIFont systemFontOfSize:12];
    
}





@end
