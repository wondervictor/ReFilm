//
//  HotMovieView.h
//  ReFilm
//
//  Created by VicChan on 5/13/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, MovieViewType) {
    MovieViewTypeHotMovie,
    MovieViewTypeComingMovie
};


@protocol HotMovieViewDelegate <NSObject>

- (void)touchCollectionView:(UICollectionView *)tableView CellAtIndex:(NSInteger)index inView:(UIView *)view;

- (void)longTouchCellAtIndex:(NSInteger)index;


- (void)refreshMoviesWithView:(UIView *)view;

@end



@interface HotMovieView : UIView

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, weak) id <HotMovieViewDelegate> delegate;
@property (nonatomic, assign) MovieViewType movieViewType;

- (id)initWithFrame:(CGRect)frame type:(MovieViewType)type;

- (void)loadDataWithArray:(NSArray *)array;

- (void)loadError;
@end
