//
//  MovieTableCell.h
//  ReFilm
//
//  Created by VicChan on 5/12/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieTableCell : UITableViewCell


@property (nonatomic, strong) UIImageView *movieImage;

@property (nonatomic, strong) UILabel *movieName;

@property (nonatomic, strong) UILabel *ratingLabel;

@property (nonatomic, strong) UILabel *directorLabel;

@property (nonatomic, strong) UILabel *actorsLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
