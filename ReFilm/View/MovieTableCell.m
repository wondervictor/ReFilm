//
//  MovieTableCell.m
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import "MovieTableCell.h"
#import <Masonry.h>


@interface MovieTableCell()

@end

@implementation MovieTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureSubViews];
    }
    return self;
}

- (void)configureSubViews {
    
    self.movieImage = [[UIImageView alloc]initWithFrame:CGRectMake(4, 5, 49, 70)];
    [self.contentView addSubview:self.movieImage];

    self.ratingLabel = [UILabel new];
    [self.contentView addSubview:self.ratingLabel];
    [self.ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.width.equalTo(@40);
        make.height.equalTo(@70);
    }];
    
    

    self.movieName = [UILabel new];
    [self.contentView addSubview:self.movieName];
    [self.movieName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.movieImage.mas_right).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.height.equalTo(@30);
        make.right.equalTo(self.ratingLabel.mas_left).with.offset(-5);
    }];
    
    
    self.directorLabel = [UILabel new];
    [self.contentView addSubview:self.directorLabel];
    [self.directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.movieName.mas_bottom);
        make.left.equalTo(self.movieImage.mas_right).with.offset(5);
        make.height.equalTo(@20);
        make.right.equalTo(self.ratingLabel.mas_left).with.offset(-5);
    }];
    
    self.actorsLabel = [UILabel new];
    [self.contentView addSubview:self.actorsLabel];
    [self.actorsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.directorLabel.mas_bottom);
        make.left.equalTo(self.movieImage.mas_right).with.offset(5);
        make.height.equalTo(@20);
        make.right.equalTo(self.ratingLabel.mas_left).with.offset(-5);
    }];
    

}






@end
