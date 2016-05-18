//
//  RFViewModel.h
//  ReFilm
//
//  Created by VicChan on 5/18/16.
//  Copyright © 2016 VicChan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "MovieCollectionCell.h"
#import "MovieTableCell.h"
#import "Movie.h"
#import "FavorieMovies.h"

@interface RFViewModel : NSObject


/// 处理Movie的Model
- (void)handleCollectionCell:(MovieCollectionCell *)cell withMovie:(Movie *)movie;


/// 处理FavoriteMovie的Model
- (void)handleTableCell:(MovieTableCell *)cell withFavoriteMovies:(FavorieMovies *)movie;

/// 测试使用－－－ 处理CollectionView的 FavoriteMovie

- (void)handleCollectionCell:(MovieCollectionCell *)cell withFavoriteMovies:(FavorieMovies *)movie;



@end
