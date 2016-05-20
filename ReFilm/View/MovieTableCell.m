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
        make.width.equalTo(@60);
        make.height.equalTo(@70);
    }];
    self.ratingLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20];
    self.ratingLabel.textColor = [UIColor orangeColor];
    self.ratingLabel.adjustsFontSizeToFitWidth = YES;
    self.ratingLabel.textAlignment = NSTextAlignmentCenter;
    
    self.movieName = [UILabel new];
    [self.contentView addSubview:self.movieName];
    [self.movieName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.movieImage.mas_right).with.offset(5);
        make.top.equalTo(self.contentView.mas_top).with.offset(5);
        make.height.equalTo(@30);
        make.right.equalTo(self.ratingLabel.mas_left).with.offset(-5);
    }];
    self.movieName.adjustsFontSizeToFitWidth = YES;
    
    self.directorLabel = [UILabel new];
    [self.contentView addSubview:self.directorLabel];
    [self.directorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.movieName.mas_bottom);
        make.left.equalTo(self.movieImage.mas_right).with.offset(5);
        make.height.equalTo(@20);
        make.right.equalTo(self.ratingLabel.mas_left).with.offset(-5);
    }];
    self.directorLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    self.directorLabel.textColor = [UIColor lightGrayColor];
    
    self.actorsLabel = [UILabel new];
    [self.contentView addSubview:self.actorsLabel];
    [self.actorsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.directorLabel.mas_bottom);
        make.left.equalTo(self.movieImage.mas_right).with.offset(5);
        make.height.equalTo(@20);
        make.right.equalTo(self.ratingLabel.mas_left).with.offset(-5);
    }];
    self.actorsLabel.textColor = [UIColor lightGrayColor];
    self.actorsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    self.actorsLabel.adjustsFontSizeToFitWidth = YES;
    
    

}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *subView in self .subviews) {
        if ([subView isKindOfClass:NSClassFromString(@"UITableViewCellDeleteConfirmationView")]) {
            UIView *confirmView = (UIView *)[subView.subviews firstObject];
            confirmView.backgroundColor=[UIColor greenColor];
            
            break;

        }
    }
}






@end
