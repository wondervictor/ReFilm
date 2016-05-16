//
//  HotMovieView.h
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol HotMovieViewDelegate <NSObject>

- (void)touchCellAtIndex:(NSInteger)index;

- (void)longTouchCellAtIndex:(NSInteger)index;

@end




@interface HotMovieView : UIView

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, weak) id <HotMovieViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame;

- (void)loadDataWithArray:(NSArray *)array;

@end
