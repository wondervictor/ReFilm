//
//  HotMovieView.h
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotMovieView : UIView

@property (nonatomic, strong) NSArray *movies;


- (id)initWithFrame:(CGRect)frame;

- (void)loadDataWithArray:(NSArray *)array;

@end
