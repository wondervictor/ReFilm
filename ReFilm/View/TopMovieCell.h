//
//  TopMovieCell.h
//  ReFilm
//
//  Created by VicChan on 5/16/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopMovieCell : UITableViewCell

@property (nonatomic, strong) UIImageView *movieImageView;

@property (nonatomic, strong) UILabel *movieTitleLabel;

@property (nonatomic, strong) UILabel *yearLabel;

@property (nonatomic, strong) UILabel *typeLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setMovieImage:(UIImage *)image;

@end
