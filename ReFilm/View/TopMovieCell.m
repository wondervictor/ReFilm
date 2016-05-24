//
//  TopMovieCell.m
//  ReFilm
//
//  Created by VicChan on 5/16/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "TopMovieCell.h"
#import <Masonry.h>

@interface TopMovieCell()

@property (nonatomic, strong) UIVisualEffectView *visualView;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIImageView *backImageView;

@end


@implementation TopMovieCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubViews];
    }
    return self;
}

- (void)setMovieImage:(UIImage *)image {
    self.image = image;
    _backImageView.image = image;
    _movieImageView.image = image;
}


- (void)configureSubViews {
    _backImageView = [UIImageView new];
    [self.contentView addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.right.equalTo(self.contentView.mas_right);
        make.left.equalTo(self.contentView.mas_left);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    _visualView = [[UIVisualEffectView alloc]initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    [_backImageView addSubview:_visualView];
    [_visualView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_backImageView.mas_top);
        make.right.equalTo(_backImageView.mas_right);
        make.left.equalTo(_backImageView.mas_left);
        make.bottom.equalTo(_backImageView.mas_bottom);
    }];
    
    _movieImageView = [UIImageView new];
    [_visualView addSubview:_movieImageView];
    
    [_movieImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_visualView.mas_top).with.offset(5);
        //make.bottom.equalTo(_visualView.mas_bottom).with.offset(-5);
        make.left.equalTo(_visualView.mas_left).with.offset(5);
        //make.width.equalTo([NSNumber numberWithFloat:self.contentView.frame.size.height-10]).multipliedBy(42/60.0);
        make.height.equalTo(@110);
        make.width.equalTo([NSNumber numberWithFloat:110*42/60.0]);
    }];
    
    _movieTitleLabel = [UILabel new];
    [_visualView addSubview:_movieTitleLabel];
    [_movieTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.right.equalTo(_visualView.mas_right).with.offset(-10);
        make.left.equalTo(_movieImageView.mas_right).with.offset(10);
        make.top.equalTo(_visualView.mas_top).with.offset(5);
    }];
    
    _movieTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];

    
    _typeLabel = [UILabel new];
    [_visualView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.right.equalTo(_visualView.mas_right).with.offset(-10);
        make.left.equalTo(_movieImageView.mas_right).with.offset(10);
        make.top.equalTo(_movieTitleLabel.mas_bottom).with.offset(2);
    }];
    _typeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    
    
    _yearLabel = [UILabel new];
    [_visualView addSubview:_yearLabel];
    [_yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.right.equalTo(_visualView.mas_right).with.offset(-5);
        make.left.equalTo(_movieImageView.mas_right).with.offset(10);
        make.top.equalTo(_typeLabel.mas_bottom).with.offset(2);
    }];
    _yearLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];

    /*
    _ratingLabel = [UILabel new];
    [_visualView addSubview:_ratingLabel];
    [_ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@30);
        make.right.equalTo(_visualView.mas_right).with.offset(-10);
        make.left.equalTo(_yearLabel.mas_right).with.offset(10);
        make.top.equalTo(_typeLabel.mas_bottom).with.offset(2);
    }];
    */
    
    
}

@end
